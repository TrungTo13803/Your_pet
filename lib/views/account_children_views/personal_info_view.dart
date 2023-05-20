import 'package:demo/constrants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff5f5f7),
          iconTheme: const IconThemeData(color: Color(0xff212121)),
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: FittedBox(
                    child: Text("Personal Information",
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)))),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(accountRoute);
              },
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Color(0xFF0f67ca),
                size: 24,
              )),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Center(
                        child: Icon(CupertinoIcons.person_alt_circle_fill,
                            size: 90,
                            color: Color.fromARGB(255, 110, 110, 110)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Change photo',
                          style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: FittedBox(
                                child: Text('Email',
                                    style: TextStyle(
                                        color: Color(0xff212121),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(
                                          'Change email',
                                          style: TextStyle(
                                            color: Color(0xff212121),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        content: const Text(
                                          'Do you want to change your email?',
                                          style: TextStyle(
                                            color: Color(0xff212121),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                  color: Color(0xff0f67ca),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(changeEmailRoute);
                                            },
                                            child: const Text('Yes',
                                                style: TextStyle(
                                                  color: Color(0xff0f67ca),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentUser!.email.toString(),
                                      style: const TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Icon(CupertinoIcons.chevron_right,
                                        size: 20, color: Color(0xff212121)),
                                  ],
                                ),
                              ],
                            )),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: FittedBox(
                                    child: Text('Password',
                                        style: TextStyle(
                                            color: Color(0xff212121),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400))))),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Change password',
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Icon(CupertinoIcons.chevron_right,
                                      size: 20, color: Color(0xff212121)),
                                ],
                              ),
                            ],
                          ),
                        )
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
