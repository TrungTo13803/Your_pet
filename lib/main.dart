import 'package:flutter/material.dart';
import 'package:demo/views/main_windows.dart';

void main() => runApp(const MyHome());

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage()
    );
  }
}

