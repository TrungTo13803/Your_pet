import 'package:flutter/material.dart';
//import 'package:flutter/gestures.dart';
//import 'dart:ui';
//import 'package:google_fonts/google_fonts.dart';
//import '/util.dart';
import 'package:demo/views/notifications_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffe15d),
        title: Container(
          margin: const EdgeInsets.fromLTRB(110, 0, 0, 0),
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

        actions: [
          IconButton(
            padding:const EdgeInsets.fromLTRB(0, 0, 10, 0),
            icon : const Icon(
              Icons.notifications,
              size: 21,
              color: Color(0xff212121),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          )
        ],
      ),

      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 24),
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
                    child: const Text('See all'),
                    onPressed: () {},
                  ),
                )
              ],
            ),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [
                      Container(
                          width: 155,
                          height: 145,
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xffFF8B8B),
                              boxShadow:const [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  offset: Offset(3, 4),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ]
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(20, 10, 0 , 0),
                                      child: const Text(
                                        'Ben',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff212121),
                                        ),
                                      ),
                                    ),

                                    Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: IconButton (
                                          icon: const Icon(
                                            //_buttonPressed_Widget1_YourPetsList ? Icons.favorite_outline : Icons.favorite,
                                            Icons.favorite,
                                            size: 21,
                                          ),
                                          onPressed: () {
                                            //setState(() {
                                              //_buttonPressed_Widget1_YourPetsList = !_buttonPressed_Widget1_YourPetsList;
                                            //});
                                          },
                                        )
                                    )
                                  ]
                              ),

                              Container(
                                  margin: const EdgeInsets.fromLTRB(20, 5, 0 , 5),
                                  child: const Text(
                                      'Dog',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff212121)
                                      )
                                  )
                              ),

                              Container(
                                  width: 70,
                                  height: 32.5,
                                  margin: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0051FF),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                        )
                                    ),
                                    onPressed: () {},
                                  )
                              )
                            ],
                          )
                      ),

                      Container(
                          width: 155,
                          height: 145,
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xff99FFE0),
                              boxShadow:const [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  offset: Offset(3, 4),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ]
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(20, 10, 0 , 0),
                                        child: const Text(
                                          'Tom',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff212121),
                                          ),
                                        ),
                                      ),

                                      Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              //_buttonPressed_Widget2_YourPetsList ? Icons.favorite_outline : Icons.favorite,
                                              Icons.favorite,
                                              size: 21,
                                            ),
                                            onPressed: () {}

                                              //setState(() {
                                                //_buttonPressed_Widget2_YourPetsList = !_buttonPressed_Widget2_YourPetsList;

                                            //},
                                          )
                                      )
                                    ]
                                ),

                                Container(
                                    margin: const EdgeInsets.fromLTRB(20, 5, 0 , 5),
                                    child: const Text(
                                        'Cat',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff212121)
                                        )
                                    )
                                ),

                                Container(
                                    width: 70,
                                    height: 32.5,
                                    margin: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0051FF),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextButton(
                                      child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                          )
                                      ),
                                      onPressed: () {},
                                    )
                                )
                              ]
                          )
                      ),
                    ],
                  )
                ]
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: const Text(
                          'Ongoing events',
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
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline
                          )
                      ),
                      child: const Text('See all'),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: 370,
                    height: 120,
                    decoration: BoxDecoration(
                      color:  const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(3, 4),
                          color: Color(0x40000000),
                          spreadRadius: 1,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: const Text(
                                  'Giving pills to Ben',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff212121),
                                  )
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: const Text(
                                  '9:00 AM, Today',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff212121),
                                  )
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: const Text(
                                  'Ben',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff212121),
                                  )
                              ),
                            ),

                            Container(
                                width: 70,
                                height: 35,
                                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0051FF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextButton(
                                  child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                      )
                                  ),
                                  onPressed: () {},
                                )
                            )
                          ],
                        )
                      ],
                    )
                ),

                Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    width: 370,
                    height: 120,
                    decoration: BoxDecoration(
                      color:  const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(3, 4),
                          color: Color(0x40000000),
                          spreadRadius: 1,
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: const Text(
                                    'Bathe Ben',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff212121),
                                    )
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: const Text(
                                    '10:00 AM, Today',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121),
                                    )
                                ),
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: const Text(
                                    'Ben',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121),
                                    )
                                ),
                              ),

                              Container(
                                  width: 70,
                                  height: 35,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0051FF),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                        )
                                    ),
                                    onPressed: () {},
                                  )
                              )
                            ],
                          )
                        ]
                    )
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

          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 21,
              ),
              label: 'Settings'
          )
        ],
        selectedItemColor: const Color(0xff212121),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: const Color(0xffd9d9d9),
      ),


    );
  }
}





      