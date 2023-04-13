import 'package:demo/constrants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

enum MenuAction { logout }
class _AccountPageState extends State<AccountPage> {
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
            Navigator.of(context).pushNamedAndRemoveUntil(
              homeRoute,
              (route) => false
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 21,
          )
        ),

        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                )
              ];
            }
          )
        ]
      ),  
      
      body: Column(
        children: [
          Row(
            children: [
              
              
            ],
          )        
        ],
      )
    );  
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel')
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out')
          )
        ],
      );
    } 
  ).then((value) => value ?? false);
}

