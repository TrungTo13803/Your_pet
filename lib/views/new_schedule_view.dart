import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/cloud_schedule.dart';
import 'package:demo/services/local_notifications/local_notifications_service.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class CreateScheduleView extends StatefulWidget {
  const CreateScheduleView({Key? key}) : super(key: key);

  @override
  State<CreateScheduleView> createState() => _CreateScheduleViewState();
}

class _CreateScheduleViewState extends State<CreateScheduleView> {
  CloudSchedule? _schedule;
  late final FirebaseCloudStorage _appService = FirebaseCloudStorage();
  String get userId => AuthService.firebase().currentUser!.id;

  late final TextEditingController _nameEditingController;
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _petNameEditingController;
  late DateTime _dateTime;
  late TimeOfDay _time;
  late DateTime _date;

  @override
  void initState() {
    tz.initializeTimeZones();
    NotificationService().initNotification();
    _nameEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    _petNameEditingController = TextEditingController();
    _dateTime = DateTime.now();
    _date = DateTime.now();
    _time = TimeOfDay.now();
    super.initState();
  }

  void _textEditingControllerListener() async {
    final schedule = _schedule;
    if (schedule == null) {
      return;
    }
    await _appService.updateSchedule(
      documentId: schedule.documentId,
      activityTitle: _nameEditingController.text,
      activityDescription: _descriptionEditingController.text,
      activityTime: _time.toString(),
      activityDate: _date.toString(),
      petName: _petNameEditingController.text,
    );
  }

  void _setUpNameEditingControllerListener() {
    _nameEditingController.removeListener(_textEditingControllerListener);
    _nameEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpDescriptionEditingControllerListener() {
    _descriptionEditingController
        .removeListener(_textEditingControllerListener);
    _descriptionEditingController.addListener(_textEditingControllerListener);
  }

  Future<CloudSchedule> createSchedule(BuildContext context) async {
    final widgetNote = context.getArgument<CloudSchedule>();

    if (widgetNote != null) {
      _schedule = widgetNote;
      _nameEditingController.text = widgetNote.activityTitle;
      _descriptionEditingController.text = widgetNote.activityDescription;
      _time = TimeOfDay(
          hour: int.parse(widgetNote.activityTime.split(":")[0]),
          minute: int.parse(widgetNote.activityTime.split(":")[1]));
      _date = DateTime.parse(widgetNote.activityDate);

      return widgetNote;
    }

    final existingNote = _schedule;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newSchedule =
        await _appService.createNewSchedule(ownerUserId: userId);
    _schedule = newSchedule;

    return newSchedule;
  }

  void _deleteIfTextIsEmpty() async {
    final schedule = _schedule;
    if (_nameEditingController.text.isEmpty &&
        _descriptionEditingController.text.isEmpty &&
        _petNameEditingController.text.isEmpty &&
        schedule != null) {
      await _appService.deleteSchedule(documentId: schedule.documentId);
    }
  }

  void _deleteIfTapOnBackButton() async {
    final schedule = _schedule;
    if (schedule != null &&
        _petNameEditingController.text.isNotEmpty &&
        _nameEditingController.text.isNotEmpty &&
        _descriptionEditingController.text.isEmpty) {
      await _appService.deleteSchedule(documentId: schedule.documentId);
    } else {
      _deleteIfTextIsEmpty();
    }
  }

  void _saveIfTapOnAddButton() async {
    final schedule = _schedule;

    if (schedule != null &&
        (_nameEditingController.text.isNotEmpty ||
            _descriptionEditingController.text.isNotEmpty ||
            _petNameEditingController.text.isNotEmpty)) {
      await _appService.updateSchedule(
          documentId: schedule.documentId,
          activityTitle: _nameEditingController.text,
          activityDescription: _descriptionEditingController.text,
          activityTime: _time.toString(),
          activityDate: _date.toString(),
          petName: _petNameEditingController.text);
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _deleteIfTapOnBackButton();
    _nameEditingController.dispose();
    _descriptionEditingController.dispose();
    _nameEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: createSchedule(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _setUpNameEditingControllerListener();
                  _setUpDescriptionEditingControllerListener();
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SingleChildScrollView(
                        child: SafeArea(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 14, 10, 10),
                                  child: FittedBox(
                                      child: IconButton(
                                    onPressed: () {
                                      _deleteIfTapOnBackButton();
                                      Navigator.of(context)
                                          .pushNamed(scheduleRoute);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.arrow_left,
                                      size: 24,
                                      color: Color(0xFF0f67ca),
                                    ),
                                  )),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
                                  child: Text("Schedule a activity",
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 12, 8, 8),
                                          child: TextButton(
                                              onPressed: () async {
                                                _saveIfTapOnAddButton();
                                                await NotificationService()
                                                    .scheduleNotification(
                                                  body: 'Notification',
                                                  title: 'Hello',
                                                  scheduledNotificationDateTime:
                                                      _dateTime,
                                                );
                                                Navigator.of(context)
                                                    .pushNamed(scheduleRoute);
                                              },
                                              child: const Text('Add',
                                                  style: TextStyle(
                                                      color: Color(0xff0f67ca),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400))))
                                    ]))
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                        controller: _petNameEditingController,
                                        keyboardType: TextInputType.multiline,
                                        maxLength: null,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff212121),
                                        ),
                                        decoration: const InputDecoration(
                                            labelText: "Schedule for",
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ))))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                        controller: _nameEditingController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff212121),
                                        ),
                                        decoration: const InputDecoration(
                                            labelText: "Activity name",
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ))))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                        controller:
                                            _descriptionEditingController,
                                        keyboardType: TextInputType.multiline,
                                        maxLength: null,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff212121),
                                        ),
                                        decoration: const InputDecoration(
                                            labelText: "Activity description",
                                            labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ))))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Column(
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await showDatePicker(
                                                        context: context,
                                                        initialDate: _date,
                                                        firstDate:
                                                            DateTime(2010),
                                                        lastDate:
                                                            DateTime(2100))
                                                    .then(
                                                        (value) => setState(() {
                                                              _date = value!;
                                                              _date = DateTime(
                                                                _date.year,
                                                                _date.month,
                                                                _date.day,
                                                                _time.hour,
                                                                _time.minute,
                                                              );

                                                              _dateTime =
                                                                  DateTime(
                                                                _date.year,
                                                                _date.month,
                                                                _date.day,
                                                                _time.hour,
                                                                _time.minute,
                                                              );
                                                            }));
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Date'),
                                                    Row(children: [
                                                      Text(DateFormat(
                                                              'MM-dd-yyyy')
                                                          .format(_date)),
                                                      const Icon(CupertinoIcons
                                                          .chevron_right)
                                                    ])
                                                  ]))
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await showTimePicker(
                                                        context: context,
                                                        initialTime: _time)
                                                    .then(
                                                        (value) => setState(() {
                                                              _time = value!;
                                                              _date = DateTime(
                                                                _date.year,
                                                                _date.month,
                                                                _date.day,
                                                                _time.hour,
                                                                _time.minute,
                                                              );
                                                              _dateTime =
                                                                  DateTime(
                                                                _date.year,
                                                                _date.month,
                                                                _date.day,
                                                                _time.hour,
                                                                _time.minute,
                                                              );
                                                            }));
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Time'),
                                                    Row(children: [
                                                      Text(_time
                                                          .format(context)
                                                          .toString()),
                                                      const Icon(CupertinoIcons
                                                          .chevron_right)
                                                    ])
                                                  ]))
                                        ]),
                                  ],
                                )),
                          ],
                        )),
                      ));
                default:
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
