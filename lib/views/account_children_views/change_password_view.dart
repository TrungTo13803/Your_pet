import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_exceptions.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/views/user_auth_views/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late final TextEditingController _password;
  late final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
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
                    child: Text("Change password",
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)))),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(personalInfoRoute);
              },
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Color(0xFF0f67ca),
                size: 24,
              )),
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _password,
                  decoration: const InputDecoration(
                    hintText: 'Enter your new password',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    hoverElevation: 0,
                    enableFeedback: false,
                    elevation: 0,
                    onPressed: () async {
                      try {
                        await currentUser.updatePassword(_password.text);
                        await currentUser.reload();
                      } on WeakPasswordAuthException {
                        await showErrorDialogRegister(context, 'Weak password');
                      } on FirebaseAuthException catch (e) {
                        await showErrorDialogRegister(context, e.message!);
                      }
                    },
                    child: const Text('SAVE',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    color: const Color(0xFF0f67ca),
                  )),
            ])));
  }
}
