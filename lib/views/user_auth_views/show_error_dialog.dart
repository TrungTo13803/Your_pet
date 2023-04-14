import 'package:demo/constrants/routes.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialogLogin(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
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
            child: const Text('OK', style: TextStyle(color: Color(0xff7e57c2))),
          ),
        ]),
  );
}

Future<void> showErrorDialogRegister(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xff7e57c2))),
          ),
        ]),
  );
}
