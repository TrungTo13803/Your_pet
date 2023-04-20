import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';

class CreateOrUpdatePetView extends StatefulWidget {
  const CreateOrUpdatePetView({Key? key}) : super(key: key);

  @override
  State<CreateOrUpdatePetView> createState() => _CreateOrUpdatePetViewState();
}

class _CreateOrUpdatePetViewState extends State<CreateOrUpdatePetView> {
  CloudPet? _pet;
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _nameEditingController;
  late final TextEditingController _typeEditingController;
  late final TextEditingController _descriptionEditingController;
  late final TextEditingController _ageEditingController;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _nameEditingController = TextEditingController();
    _typeEditingController = TextEditingController();
    _ageEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
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
      petType: type,
      petDescription: description,
      petAge: age,
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

  Future<CloudPet> createOrGetExistingPet(BuildContext context) async {
    final widgetNote = context.getArgument<CloudPet>();

    if (widgetNote != null) {
      _pet = widgetNote;
      _nameEditingController.text = widgetNote.petName;
      _typeEditingController.text = widgetNote.petType;
      _descriptionEditingController.text = widgetNote.petDescription;
      _ageEditingController.text = widgetNote.petAge;
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
        _typeEditingController.text.isEmpty &&
        _descriptionEditingController.text.isEmpty &&
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
        type.isNotEmpty &&
        description.isNotEmpty) {
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
    if (pet != null && name.isNotEmpty ||
        (type.isNotEmpty || age.isNotEmpty || description.isNotEmpty)) {
      await _appService.updatePet(
        documentId: pet!.documentId,
        petName: name,
        petType: type,
        petDescription: description,
        petAge: age,
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
                  _setUpTypeEditingControllerListener();
                  _setUpDescriptionEditingControllerListener();
                  _setUpAgeEditingControllerListener();
                  return SingleChildScrollView(
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
                                    Navigator.of(context).pushNamed(homeRoute);
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
                                child: Text('Add a pet',
                                    style: TextStyle(
                                        color: Color(0xff212121),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 60,
                              child: TextField(
                                controller: _nameEditingController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 60,
                              child: TextField(
                                controller: _typeEditingController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    labelText: "Type",
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 60,
                              child: TextField(
                                controller: _descriptionEditingController,
                                keyboardType: TextInputType.name,
                                maxLength: null,
                                decoration: const InputDecoration(
                                    labelText: "Description",
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 60,
                              child: TextField(
                                controller: _ageEditingController,
                                keyboardType: TextInputType.name,
                                maxLength: null,
                                decoration: const InputDecoration(
                                    labelText: "Age",
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                  elevation: 0,
                                  color: const Color(0xFF0051FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  onPressed: () {
                                    _safeIfTapOnAddButton();
                                    Navigator.of(context)
                                        .pushNamed(petsListRoute);
                                  },
                                  child: const Text('Add',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))))
                        ],
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
