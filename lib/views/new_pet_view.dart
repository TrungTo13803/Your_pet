import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';

class CreatePetView extends StatefulWidget {
  const CreatePetView({Key? key}) : super(key: key);

  @override
  State<CreatePetView> createState() => _CreatePetViewState();
}

class _CreatePetViewState extends State<CreatePetView> {
  List<String> types = ['Select', 'Dog', 'Cat', 'Bird', 'Fish', 'Other'];
  String? selectedType = 'Select';

  List<String> dateTypes = ['Select', 'Day(s)', 'Month(s)', 'Year(s)'];
  String? selectedDateType = 'Select';
  CloudPet? _pet;
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _nameEditingController;
  late final TextEditingController _typeEditingController;
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _ageEditingController;
  late final TextEditingController _diseaseEditingController;
  late final TextEditingController _lastTimeSickEditingController;
  late final TextEditingController _weightEditingController;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _nameEditingController = TextEditingController();
    _typeEditingController = TextEditingController();
    _ageEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    _diseaseEditingController = TextEditingController();
    _lastTimeSickEditingController = TextEditingController();
    _weightEditingController = TextEditingController();
    super.initState();
  }

  void _textEditingControllerListener() async {
    final pet = _pet;
    if (pet == null) {
      return;
    }
    final name = _nameEditingController.text;
    final type = _typeEditingController.text;
    final description = _descriptionEditingController.text;
    final age = _ageEditingController.text;
    await _appService.updatePet(
      documentId: pet.documentId,
      petName: name,
      petType: selectedType!,
      petDescription: description,
      petAge: age,
      petDisease: _diseaseEditingController.text,
      lastTimeSick:
          '${_lastTimeSickEditingController.text} ${selectedDateType!} ago',
      weight: _weightEditingController.text,
    );
  }

  void _setUpNameEditingControllerListener() {
    _nameEditingController.removeListener(_textEditingControllerListener);
    _nameEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpTypeEditingControllerListener() {
    _typeEditingController.removeListener(_textEditingControllerListener);
    _typeEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpDescriptionEditingControllerListener() {
    _descriptionEditingController
        .removeListener(_textEditingControllerListener);
    _descriptionEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpAgeEditingControllerListener() {
    _ageEditingController.removeListener(_textEditingControllerListener);
    _ageEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpDiseaseEditingControllerListener() {
    _diseaseEditingController.removeListener(_textEditingControllerListener);
    _diseaseEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpLastTimeSickEditingControllerListener() {
    _lastTimeSickEditingController
        .removeListener(_textEditingControllerListener);
    _lastTimeSickEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpWeightEditingControllerListener() {
    _weightEditingController.removeListener(_textEditingControllerListener);
    _weightEditingController.addListener(_textEditingControllerListener);
  }

  Future<CloudPet> createPet(BuildContext context) async {
    final widgetNote = context.getArgument<CloudPet>();

    if (widgetNote != null) {
      _pet = widgetNote;
      _nameEditingController.text = widgetNote.petName;
      _typeEditingController.text = widgetNote.petType;
      _descriptionEditingController.text = widgetNote.petDescription;
      _ageEditingController.text = widgetNote.petAge;
      _diseaseEditingController.text = widgetNote.petDisease;
      _lastTimeSickEditingController.text = widgetNote.lastTimeSick;
      _weightEditingController.text = widgetNote.weight;
      return widgetNote;
    }

    final existingNote = _pet;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newPet = await _appService.createNewPet(ownerUserId: userId);
    _pet = newPet;
    return newPet;
  }

  void _deleteIfTextIsEmpty() {
    final pet = _pet;
    if (_nameEditingController.text.isEmpty &&
        selectedType == 'Select' &&
        _descriptionEditingController.text.isEmpty &&
        _ageEditingController.text.isEmpty &&
        _diseaseEditingController.text.isEmpty &&
        _lastTimeSickEditingController.text.isEmpty &&
        selectedDateType == 'Select' &&
        _ageEditingController.text.isEmpty &&
        pet != null) {
      _appService.deletePet(documentId: pet.documentId);
    }
  }

  void _deleteIfTapOnBackButton() {
    final pet = _pet;
    final name = _nameEditingController.text;
    final type = _typeEditingController.text;
    final description = _descriptionEditingController.text;
    final age = _ageEditingController.text;
    if (pet != null &&
        name.isNotEmpty &&
        age.isNotEmpty &&
        selectedType != 'Select' &&
        description.isNotEmpty &&
        _diseaseEditingController.text.isNotEmpty &&
        _lastTimeSickEditingController.text.isNotEmpty &&
        selectedDateType != 'Select' &&
        _weightEditingController.text.isNotEmpty) {
      _appService.deletePet(documentId: pet.documentId);
    } else {
      _deleteIfTextIsEmpty();
    }
  }

  void _safeIfTapOnAddButton() async {
    final pet = _pet;
    final name = _nameEditingController.text;
    final type = _typeEditingController.text;
    final description = _descriptionEditingController.text;
    final age = _ageEditingController.text;
    final disease = _diseaseEditingController.text;
    final lastTimeSick = _lastTimeSickEditingController.text;
    if (pet != null &&
        (name.isNotEmpty ||
            age.isNotEmpty ||
            selectedType != 'Select' ||
            description.isNotEmpty ||
            disease.isNotEmpty ||
            (lastTimeSick.isNotEmpty && selectedDateType != 'Select') ||
            _weightEditingController.text.isNotEmpty)) {
      await _appService.updatePet(
        documentId: pet.documentId,
        petName: name,
        petType: selectedType!,
        petDescription: description,
        petAge: age,
        petDisease: disease,
        lastTimeSick: '$lastTimeSick ${selectedDateType!} ago',
        weight: _weightEditingController.text,
      );
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _deleteIfTapOnBackButton();

    _nameEditingController.dispose();
    _typeEditingController.dispose();
    _descriptionEditingController.dispose();
    _ageEditingController.dispose();
    _diseaseEditingController.dispose();
    _lastTimeSickEditingController.dispose();
    _weightEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        // resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: createPet(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _setUpNameEditingControllerListener();
                  _setUpWeightEditingControllerListener();
                  _setUpDescriptionEditingControllerListener();
                  _setUpAgeEditingControllerListener();
                  _setUpDiseaseEditingControllerListener();
                  _setUpLastTimeSickEditingControllerListener();
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
                                        .pushNamed(petsListRoute);
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
                                child: Text("Add a pet",
                                    style: TextStyle(
                                        color: Color(0xff212121),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 12, 8, 8),
                                          child: TextButton(
                                              onPressed: () {
                                                if (_ageEditingController
                                                        .text.isEmpty ||
                                                    _descriptionEditingController
                                                        .text.isEmpty ||
                                                    _nameEditingController
                                                        .text.isEmpty ||
                                                    _weightEditingController
                                                        .text.isEmpty ||
                                                    _diseaseEditingController
                                                        .text.isEmpty ||
                                                    _lastTimeSickEditingController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please fill all the fields')));
                                                  return;
                                                }
                                                _safeIfTapOnAddButton();
                                                Navigator.of(context)
                                                    .pushNamed(petsListRoute);
                                              },
                                              child: const Text('Add',
                                                  style: TextStyle(
                                                      color: Color(0xff0f67ca),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400)))),
                                    ]),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
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
                                    labelText: "Pet's name",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                                child: Text(
                                  'Animal type',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff2212121),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: SizedBox(
                                    width: 100,
                                    height: 45,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(),
                                      value: selectedType,
                                      items: types
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff212121),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        selectedType = item!;
                                      }),
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 3, 20, 5),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _ageEditingController,
                                keyboardType: TextInputType.name,
                                maxLength: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                ),
                                decoration: const InputDecoration(
                                    labelText: "Age",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 3, 20, 5),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _weightEditingController,
                                keyboardType: TextInputType.name,
                                maxLength: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                ),
                                decoration: const InputDecoration(
                                    labelText: "Weight (kg)",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              'Have your pet ever had diseases?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2212121),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _diseaseEditingController,
                                keyboardType: TextInputType.multiline,
                                maxLength: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                ),
                                decoration: const InputDecoration(
                                    labelText:
                                        "If yes, please specify. If no, leave blank.",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              'When was the last time your pet got sick?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2212121),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: TextField(
                                    controller: _lastTimeSickEditingController,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff212121),
                                    ),
                                    decoration: const InputDecoration(
                                        hintText: "1 month ago?",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    width: 100,
                                    height: 45,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(),
                                      value: selectedDateType,
                                      items: dateTypes
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff212121),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        selectedDateType = item!;
                                      }),
                                    ),
                                  ),
                                ),
                                Text('ago'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _descriptionEditingController,
                                keyboardType: TextInputType.multiline,
                                maxLength: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                ),
                                decoration: const InputDecoration(
                                    labelText: "Write something about your pet",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  );
                default:
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
