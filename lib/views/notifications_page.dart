import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Flexible(
          //margin: const EdgeInsets.fromLTRB(75, 0, 0, 0),
          child: Text("Notifications",
              style: TextStyle(
                  color: Color(0xff212121),
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              )),),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 21,
          )
        ),

        backgroundColor: const Color(0xffffe15d),
        iconTheme: const IconThemeData(
          color: Color(0xff212121)
        ),
      ),


      //body:

    );
  }
}

