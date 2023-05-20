import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_exceptions.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/views/user_auth_views/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeEmailView extends StatefulWidget {
  const ChangeEmailView({super.key});

  @override
  State<ChangeEmailView> createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  late final TextEditingController _email;
  late final currentUser = FirebaseAuth.instance.currentUser;

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
        resizeToAvoidBottomInset: false,
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
                    child: Text("Change email",
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
                  controller: _email,
                  decoration: const InputDecoration(
                    hintText: 'Enter your new email',
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
                        await currentUser!.updateEmail(_email.text);
                        await currentUser!.reload();
                        await AuthService.firebase().sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on EmailAlreadyInUseAuthException {
                        await showErrorDialogRegister(
                            context, 'Email already in use');
                      } on InvalidEmailAuthException {
                        await showErrorDialogRegister(context, 'Invalid email');
                      } on GenericAuthException {
                        await showErrorDialogRegister(context, 'Error');
                      }
                    },
                    child: const Text('SAVE',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    color: const Color(0xFF0f67ca),
                  )),
            ])));
  }
}
