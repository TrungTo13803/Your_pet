import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/views/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

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
                    child: Text("Account",
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)))),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(homeRoute);
              },
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Color(0xFF0f67ca),
                size: 24,
              )),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.bell,
                color: Color(0xFF0f67ca),
                size: 23,
              ),
              onPressed: () async {},
            )
          ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 10, 10),
                              child: FittedBox(
                                child: Text('Your Personal Profile',
                                    style: TextStyle(
                                        color: Color(0xff0f67ca),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FittedBox(
                                child: Text('email',
                                    style: const TextStyle(
                                        color: Color(0xff212121),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.person_crop_circle_fill,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Personal info',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushNamed(
                          personalInfoRoute,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.chat_bubble_2_fill,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Message Center',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.shield_lefthalf_fill,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Login and security',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.eye_solid,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Data and privacy',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.bell_solid,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Notification Preferences',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.news_solid,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'News Preferences',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.question_circle_fill,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Help',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.person_crop_circle_fill_badge_xmark,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Close your account',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {},
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: const Color(0xffffffff),
                      child: Row(
                        children: const [
                          Icon(
                            CupertinoIcons.square_arrow_left_fill,
                            color: Color(0xFF0f67ca),
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Log out',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        final signOut = await showLogOutDialog(context);
                        if (signOut) {
                          await AuthService.firebase().logOut();
                          Navigator.of(context).pushNamed(loginRoute);
                        }
                      },
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FittedBox(
                                child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Legal Agreements',
                                style: TextStyle(
                                  color: Color(0xff212121),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: FittedBox(
                                  child: Text('Version 1.0.0',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
