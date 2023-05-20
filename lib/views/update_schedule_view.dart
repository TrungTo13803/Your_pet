import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/services/cloud/cloud_schedule.dart';
import 'package:demo/services/local_notifications/local_notifications_service.dart';
import 'package:demo/utilities/dialogs/delete_dialog.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:demo/services/cloud/firebase_cloud_storage.dart';
import 'package:intl/intl.dart';

class UpdateScheduleView extends StatefulWidget {
  const UpdateScheduleView({Key? key}) : super(key: key);

  @override
  State<UpdateScheduleView> createState() => _UpdateScheduleViewState();
}

class _UpdateScheduleViewState extends State<UpdateScheduleView> {
  CloudSchedule? _schedule;
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _nameEditingController;
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _petNameEditingController;
  late DateTime _dateTime = DateTime.now();
  late DateTime _currentDate = DateTime.parse(_schedule!.activityDate);
  late TimeOfDay _currentTime = TimeOfDay(
      hour: DateTime.parse(_schedule!.activityDate).hour,
      minute: DateTime.parse(_schedule!.activityDate).minute);

  @override
  void initState() {
    tz.initializeTimeZones();
    NotificationService().initNotification();
    _appService = FirebaseCloudStorage();
    _nameEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    _petNameEditingController = TextEditingController();
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
      activityTime: _currentTime.toString(),
      activityDate: _currentDate.toString(),
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

  void _setUpPetNameEditingController() {
    _petNameEditingController.removeListener(_textEditingControllerListener);
    _petNameEditingController.addListener(_textEditingControllerListener);
  }

  Future<CloudSchedule> createOrGetExistingSchedule(
      BuildContext context) async {
    final widgetNote = context.getArgument<CloudSchedule>();

    if (widgetNote != null) {
      _schedule = widgetNote;
      _nameEditingController.text = widgetNote.activityTitle;
      _descriptionEditingController.text = widgetNote.activityDescription;
      _petNameEditingController.text = widgetNote.petName;

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
        schedule != null) {
      await _appService.deleteSchedule(documentId: schedule.documentId);
    }
  }

  void _saveIfTapOnAddButton() async {
    final schedule = _schedule;

    if (schedule != null &&
        (_nameEditingController.text.isNotEmpty ||
            _descriptionEditingController.text.isNotEmpty)) {
      await _appService.updateSchedule(
          documentId: schedule.documentId,
          activityTitle: _nameEditingController.text,
          activityDescription: _descriptionEditingController.text,
          activityTime: _currentTime.toString(),
          activityDate: _currentDate.toString(),
          petName: _petNameEditingController.text);
    }
  }

  void _deleteIfTapOnDeleteButton() async {
    final schedule = _schedule;
    if (schedule != null) {
      await _appService.deleteSchedule(documentId: schedule.documentId);
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _deleteIfTapOnDeleteButton();
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
            future: createOrGetExistingSchedule(context),
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
                                  child: Text("Edit scheduled activity",
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
                                                if (_petNameEditingController
                                                        .text.isEmpty ||
                                                    _descriptionEditingController
                                                        .text.isEmpty ||
                                                    _nameEditingController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please fill all the fields')));
                                                  return;
                                                }
                                                _saveIfTapOnAddButton();
                                                try {
                                                  await NotificationService()
                                                      .scheduleNotification(
                                                    body: 'Notification',
                                                    title: 'Hello',
                                                    scheduledNotificationDateTime:
                                                        _currentDate,
                                                  );

                                                  if (_dateTime
                                                      .isAtSameMomentAs(
                                                          DateTime.now())) {
                                                    throw Exception(ScaffoldMessenger
                                                            .of(context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Please fill all the fields'))));
                                                  }
                                                } catch (e) {
                                                  // Handle the exception here
                                                  print('Error caught: $e');
                                                }
                                              },
                                              child: const Text('Save',
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
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff212121),
                                        ),
                                        decoration: const InputDecoration(
                                            labelText: "Pet name",
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
                                    Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 5, 0, 10),
                                            child: Text(
                                                'Current scheduled date and time',
                                                style: TextStyle(
                                                    color: Color(0xff0f67ca),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      )
                                    ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          DecoratedBox(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0x29000000),
                                                      offset: Offset(0, 0),
                                                      blurRadius: 4,
                                                      spreadRadius: 1),
                                                ]),
                                            child: Column(
                                              children: [
                                                Row(children: [
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                          CupertinoIcons
                                                              .calendar,
                                                          size: 21,
                                                          color: Color(
                                                              0xff0f67ca))),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text('Date',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff212121),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      DateFormat('MM-dd-yyyy')
                                                          .format(_currentDate),
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 92, 92, 92),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ]),
                                                Row(children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .clock_fill,
                                                        size: 21,
                                                        color:
                                                            Color(0xff0f67ca)),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text('Time',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff212121),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        _currentTime
                                                            .format(context)
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    92,
                                                                    92,
                                                                    92),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                ])
                                              ],
                                            ),
                                          )
                                        ]),
                                    Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 5),
                                            child: Text(
                                                'Select new date and time',
                                                style: TextStyle(
                                                    color: Color(0xff0f67ca),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2010),
                                                          lastDate:
                                                              DateTime(2100))
                                                      .then((value) =>
                                                          setState(() {
                                                            _currentDate =
                                                                value!;
                                                            _currentDate =
                                                                DateTime(
                                                              _currentDate.year,
                                                              _currentDate
                                                                  .month,
                                                              _currentDate.day,
                                                              _currentTime.hour,
                                                              _currentTime
                                                                  .minute,
                                                            );
                                                          }));
                                                },
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('Date',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff0f67ca),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Row(children: [
                                                        Text(
                                                            DateFormat('MM-dd-yyyy')
                                                                .format(
                                                                    _currentDate),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff0f67ca),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        const Icon(
                                                            CupertinoIcons
                                                                .chevron_right,
                                                            size: 20,
                                                            color: Color(
                                                                0xff0f67ca))
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
                                                          initialTime:
                                                              TimeOfDay.now())
                                                      .then((value) =>
                                                          setState(() {
                                                            _currentTime =
                                                                value!;
                                                            _currentDate =
                                                                DateTime(
                                                              _currentDate.year,
                                                              _currentDate
                                                                  .month,
                                                              _currentDate.day,
                                                              _currentTime.hour,
                                                              _currentTime
                                                                  .minute,
                                                            );
                                                          }));
                                                },
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('Time',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff0f67ca),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Row(children: [
                                                        Text(
                                                            _currentTime
                                                                .format(context)
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff0f67ca),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .chevron_right,
                                                          size: 20,
                                                          color:
                                                              Color(0xff0f67ca),
                                                        )
                                                      ])
                                                    ]))
                                          ])
                                    ]),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      final shouldDelete =
                                                          await showDeleteDialog(
                                                              context);
                                                      if (shouldDelete) {
                                                        _deleteIfTapOnDeleteButton();
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                scheduleRoute);
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffe6352b),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]))));
                default:
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
