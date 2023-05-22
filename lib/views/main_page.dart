import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/services/cloud/cloud_note.dart';
import 'package:demo/services/cloud/cloud_pet.dart';
import 'package:demo/services/cloud/firebase_cloud_storage.dart';
import 'package:demo/views/pets_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/views/notifications_page.dart';
import 'package:path/path.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int _currentIndex = 0;
  final tabs = [
    _MainPageView(),
    _NoteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff5f5f7),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xff0f67ca),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.pen),
            label: 'Note',
          ),
        ],
      ),
    );
  }
}

class _NoteView extends StatelessWidget {
  _NoteView({Key? key}) : super(key: key);
  late final FirebaseCloudStorage _appService = FirebaseCloudStorage();
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: FittedBox(
                          child: Text(
                        'Notes',
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ))),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(createNoteRoute);
                              },
                              icon: const Icon(
                                CupertinoIcons.plus,
                                color: Color(0xFF0f67ca),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 1),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: FittedBox(
                            child: Text(
                              'Recently added',
                              style: TextStyle(
                                  color: Color(0xff212121),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: _appService.allNotes(ownerUserId: userId),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.active:
                                    if (snapshot.hasData) {
                                      final allNotes =
                                          snapshot.data as Iterable<CloudNote>;
                                      return NotesListView(
                                        note: allNotes,
                                        onTap: (note) {
                                          Navigator.of(context).pushNamed(
                                            updateNoteRoute,
                                            arguments: note,
                                          );
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive());
                                    }
                                  default:
                                    return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> note;
  final NoteCallback onTap;

  const NotesListView({
    Key? key,
    required this.note,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: note.length,
      itemBuilder: (context, index) {
        final text = note.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(text);
          },
          title: Text(
            '${text.noteTitle} (${text.petName})',
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(
            CupertinoIcons.chevron_forward,
            color: Color(0xff212121),
            size: 21,
          ),
        );
      },
    );
  }
}

class _MainPageView extends StatelessWidget {
  const _MainPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 10, 20),
                child: FittedBox(
                    child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(accountRoute);
                  },
                  icon: const Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 24,
                    color: Color(0xFF0f67ca),
                  ),
                )),
              ),
            ],
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _WelcomeBackLabel(),
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
            child: Row(
              children: const [
                FittedBox(
                  child: Text('Recent added pet',
                      style: TextStyle(
                        color: Color(0xff212121),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: FittedBox(
                                      child: Icon(
                                    CupertinoIcons.paw,
                                    size: 30,
                                    color: Color(0xFF0f67ca),
                                  ))),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 10, 10),
                                      child: FittedBox(
                                          child: Text("Your favorite pet",
                                              style: TextStyle(
                                                  color: Color(0xff212121),
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w500)))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: FittedBox(
                                          child: Text(
                                              "Recently added pet will be displayed here",
                                              style: TextStyle(
                                                  color: Color(0xff212121),
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w400)))),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(petsListRoute);
                                  },
                                  child: const Text('See all',
                                      style: TextStyle(
                                        color: Color(0xFF0f67ca),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 10, 10),
                                    child: FittedBox(
                                      child: Text(
                                        'Ongoing activity',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff434344),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: FittedBox(
                                    child: Icon(
                                      CupertinoIcons.calendar,
                                      size: 30,
                                      color: Color(0xFF0f67ca),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 10),
                                        child: FittedBox(
                                            child: Text("Keep track easily",
                                                style: TextStyle(
                                                    color: Color(0xff212121),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)))),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 10),
                                        child: FittedBox(
                                            child: Text(
                                                "Recently added activity will be display here",
                                                style: TextStyle(
                                                    color: Color(0xff212121),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400)))),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(scheduleRoute);
                                    },
                                    child: const Text('Show all',
                                        style: TextStyle(
                                          color: Color(0xFF0f67ca),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class _WelcomeBackLabel extends StatelessWidget {
  const _WelcomeBackLabel();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 8, 8),
                    child: FittedBox(
                        child: Text('Welcome back 👋',
                            style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 4, 8, 10),
                    child: FittedBox(
                      child: Text(
                        "Let's see how are your pets doing!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 80, 80, 80),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
