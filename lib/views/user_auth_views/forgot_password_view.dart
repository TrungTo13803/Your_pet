import 'dart:ffi';

import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;
  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 21,
                    color: Color(0xff212121),
                  )),
            ],
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: FittedBox(
                        child: Text(
                          'Enter your email address',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff212121)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: TextField(
                          controller: _email,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 0),
                      child: FittedBox(
                        child: TextButton(
                            onPressed: () async {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: _email.text.trim());
                                const SnackBar(
                                  content: Text(
                                      'Check your email for a link to reset your password'),
                                );
                              } on FirebaseAuthException catch (e) {
                                SnackBar(
                                  content: Text('${e.message}'),
                                );
                              }
                            },
                            child: const Text(
                              'Change password',
                              style: TextStyle(
                                  color: Color(0xff2271ff),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FittedBox(
                    child: Text(
                  "Something went wrong? Try",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121)),
                )),
                FittedBox(
                    child: TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false);
                  },
                  child: const Text(
                    'registering again!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      color: Color(0xff2271ff),
                    ),
                  ),
                ))
              ],
            ),
          ),
          const Spacer(flex: 9),
        ]));
  }
}
