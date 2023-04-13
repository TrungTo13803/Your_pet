import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffe15d),
        iconTheme: const IconThemeData(
          color: Color(0xff212121)
        ),

        title: const Padding(
          padding: EdgeInsets.fromLTRB(8, 5, 8, 10),
          child: FittedBox(
            child: Text("Account",
              style: TextStyle(            
                color: Color(0xff212121),
                fontSize: 18,
                fontWeight: FontWeight.w500
              )
            )
          )
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 21,
          )
        ),
      ),  
      
      body: Column(
        children: [
          Row(
            children: [
              MaterialButton(
                onPressed: () {},
                child: const Text('Logout',)
              )
            ],
          )        
        ],
      ) 
    );
  }
}
