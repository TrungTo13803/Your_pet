import 'package:demo/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Oops! Some thing went wrong',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
