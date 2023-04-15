import 'package:demo/constrants/routes.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialogLogin(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text('Uh oh! Something went wrong'),
        content: Text('Please check your infomation again. $message'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Register now',
                style: TextStyle(color: Color(0xff7e57c2))),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xff2271ff))),
          ),
        ]),
  );
}

Future<void> showErrorDialogRegister(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text('Uh oh! Something went wrong'),
        content: Text('Please check your infomation again. $message'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xff2271ff))),
          ),
        ]),
  );
}
