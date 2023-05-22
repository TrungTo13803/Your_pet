import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/utilities/dialogs/delete_dialog.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';

class UpdatePetView extends StatefulWidget {
  const UpdatePetView({Key? key}) : super(key: key);

  @override
  State<UpdatePetView> createState() => _UpdatePetViewState();
}

class _UpdatePetViewState extends State<UpdatePetView> {
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
      lastTimeSick: _lastTimeSickEditingController.text,
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

  Future<CloudPet> createOrGetExistingPet(BuildContext context) async {
    final widgetNote = context.getArgument<CloudPet>();

    if (widgetNote != null) {
      _pet = widgetNote;
      _nameEditingController.text = widgetNote.petName;
      _descriptionEditingController.text = widgetNote.petDescription;
      _ageEditingController.text = widgetNote.petAge;
      selectedType = widgetNote.petType;
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
        _weightEditingController.text.isEmpty &&
        pet != null) {
      _appService.deletePet(documentId: pet.documentId);
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
        name.isNotEmpty &&
        selectedType != 'Select' &&
        description.isNotEmpty &&
        age.isNotEmpty &&
        disease.isNotEmpty &&
        lastTimeSick.isNotEmpty &&
        _weightEditingController.text.isNotEmpty) {
      await _appService.updatePet(
        documentId: pet.documentId,
        petName: name,
        petType: selectedType!,
        petDescription: description,
        petAge: age,
        petDisease: disease,
        lastTimeSick: lastTimeSick,
        weight: _weightEditingController.text,
      );
    }
  }

  void _deleteIfTapOnDeleteButton() {
    final pet = _pet;
    if (pet != null) {
      _appService.deletePet(documentId: pet.documentId);
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _deleteIfTapOnDeleteButton();
    _safeIfTapOnAddButton();
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
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: createOrGetExistingPet(context),
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
                                  child: Text("Edit pet",
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
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (_ageEditingController.text.isEmpty ||
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
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Please fill all the fields')));
                                                    return;
                                                  }
                                                  _safeIfTapOnAddButton();
                                                },
                                                child: const Text('Save',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff0f67ca),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400)))),
                                      ]),
                                )
                              ],
                            ),
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
                                      labelText: "This pet is called",
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                      labelText: "Pet's age",
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                                      labelText: "Disease",
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: TextField(
                                      controller:
                                          _lastTimeSickEditingController,
                                      keyboardType: TextInputType.multiline,
                                      maxLength: null,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff212121),
                                      ),
                                      decoration: const InputDecoration(
                                          labelText: "Last time got sick",
                                          labelStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _descriptionEditingController,
                                  keyboardType: TextInputType.name,
                                  maxLength: null,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff212121),
                                  ),
                                  decoration: InputDecoration(
                                      labelText:
                                          "Something about ${_pet!.petName}",
                                      labelStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              ),
                            ),
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
                                                                petsListRoute);
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
                          ],
                        ),
                      ),
                    ),
                  );

                default:
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
