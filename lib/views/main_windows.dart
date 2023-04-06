import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yourPet',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffe15d),
          
          title: Container(
            margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
            child: const Icon(
              Icons.pets,
              size: 21,
              color: Color(0xff212121)
            ),
          ),

          leading: IconButton(
            icon: const Icon(
              Icons.account_circle,
              size: 21,
              color: Color(0xff212121),
            ),
            onPressed: () {},
          ),
          
          actions: <Widget>[
            IconButton(
              padding:const EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon : const Icon(
                Icons.notifications,
                size: 21,
                color: Color(0xff212121),  
              ),
              onPressed: () {},
            )
          ],
        ),

        body: Container(
          margin: EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 24),
                child: const Text(
                  'Welcome back 👋',
                  style: 
                    TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff212121)
                  )
                )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const Text(
                      'Your pets',
                      style: 
                        TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff212121)
                        )
                    )
                  ),
                  Container(
                    child: TextButton(
                      style: TextButton.styleFrom(textStyle: const TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline
                        )),
                      child: Text('See all'),
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 21,
              ),
              label: 'Home'
            ),
            
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 21,
              ),
              label: 'Add'
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.tips_and_updates,
                size: 21,
              ),
              label: 'Tips'
            ),
          ],
          selectedItemColor: const Color(0xff212121),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: const Color(0xffd9d9d9),
          
        ),
      
      )  
    );
  }
}
      