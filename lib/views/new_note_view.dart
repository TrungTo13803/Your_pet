import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/services/cloud/cloud_note.dart';
import 'package:demo/utilities/get_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _appService;
  late final TextEditingController _noteTitleEditingController;
  late final TextEditingController _noteEditingController;
  late final TextEditingController _petNameEditingController;

  @override
  void initState() {
    _appService = FirebaseCloudStorage();
    _noteTitleEditingController = TextEditingController();
    _noteEditingController = TextEditingController();
    _petNameEditingController = TextEditingController();

    super.initState();
  }

  void _textEditingControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    await _appService.updateNote(
      documentId: note.documentId,
      petName: _petNameEditingController.text,
      noteTitle: _noteTitleEditingController.text,
      note: _noteEditingController.text,
    );
  }

  void _setUpNoteTitleEditingController() {
    _noteTitleEditingController.removeListener(_textEditingControllerListener);
    _noteTitleEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpNoteEditingController() {
    _noteEditingController.removeListener(_textEditingControllerListener);
    _noteEditingController.addListener(_textEditingControllerListener);
  }

  void _setUpPetNameEditingController() {
    _petNameEditingController.removeListener(_textEditingControllerListener);
    _petNameEditingController.addListener(_textEditingControllerListener);
  }

  Future<CloudNote> createNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _petNameEditingController.text = widgetNote.petName;
      _noteTitleEditingController.text = widgetNote.noteTitle;
      _noteEditingController.text = widgetNote.note;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _appService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteIfTextIsEmpty() {
    final note = _note;
    if (_petNameEditingController.text.isEmpty &&
        _noteTitleEditingController.text.isEmpty &&
        _noteEditingController.text.isEmpty &&
        note != null) {
      _appService.deleteNote(documentId: note.documentId);
    }
  }

  void _deleteIfTapOnBackButton() {
    final note = _note;
    if (note != null &&
        _petNameEditingController.text.isNotEmpty &&
        _noteTitleEditingController.text.isNotEmpty &&
        _noteEditingController.text.isNotEmpty) {
      _appService.deleteNote(documentId: note.documentId);
    } else {
      _deleteIfTextIsEmpty();
    }
  }

  void _safeIfTapOnAddButton() async {
    final note = _note;

    if (note != null &&
        (_petNameEditingController.text.isNotEmpty ||
            _noteTitleEditingController.text.isNotEmpty ||
            _noteEditingController.text.isNotEmpty)) {
      await _appService.updateNote(
        documentId: note.documentId,
        petName: _petNameEditingController.text,
        noteTitle: _noteTitleEditingController.text,
        note: _noteEditingController.text,
      );
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _deleteIfTapOnBackButton();

    _noteTitleEditingController.dispose();
    _noteEditingController.dispose();
    _petNameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        // resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: createNote(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _setUpPetNameEditingController();
                  _setUpNoteTitleEditingController();
                  _setUpNoteEditingController();
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
                                    Navigator.of(context).pop();
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
                                child: Text("Add a note",
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
                                                if (_petNameEditingController
                                                        .text.isEmpty ||
                                                    _noteTitleEditingController
                                                        .text.isEmpty ||
                                                    _noteEditingController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please fill all the fields')));
                                                  return;
                                                }
                                                _safeIfTapOnAddButton();
                                                Navigator.of(context)
                                                    .pushNamed(homeRoute);
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
                                controller: _petNameEditingController,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 3, 20, 5),
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _noteTitleEditingController,
                                keyboardType: TextInputType.name,
                                maxLength: null,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                ),
                                decoration: const InputDecoration(
                                    labelText: "Title",
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
                                  height: 70,
                                  child: TextField(
                                    controller: _noteEditingController,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff212121),
                                    ),
                                    decoration: const InputDecoration(
                                        labelText: "Notes",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  )))
                        ]))),
                  );
                default:
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
