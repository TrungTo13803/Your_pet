import 'package:demo/views/account_page.dart';
import 'package:flutter/material.dart';
import 'package:demo/views/notifications_page.dart';

//import 'package:flutter/gestures.dart';
//import 'dart:ui';
//import 'package:google_fonts/google_fonts.dart';
//import '/util.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f7),
        appBar: AppBar(
          backgroundColor: const Color(0xffffe15d),

          leading: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()),
                    );
                  },

                  icon: const Icon(
                    Icons.account_circle,
                    size: 21,
                    color: Color(0xff212121),
                  )
              ),
            ),
          ),

          actions: [
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      //padding:const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      icon: const Icon(
                        Icons.notifications,
                        size: 21,
                        color: Color(0xff212121),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationsPage()),
                        );
                      },
                    ),
                  ],
                )
            )
          ],
        ),

        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _WelcomeBackLabel(),
                      _WelcomeBackSubLabel(),
                    ]
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          _YourPetsSection(),
                          _SeeAllButton(),
                        ],
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [   
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xffFF8B8B),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          offset: Offset(3, 4),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          _YourPetsLabel(),
                                          _YourPetsSubLabel(),
                                          _EditButton()
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const[
                                          _YourPetsFavouriteIcon(),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xffFF8B8B),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          offset: Offset(3, 4),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          _YourPetsLabel(),
                                          _YourPetsSubLabel(),
                                          _EditButton()
                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const[
                                          _YourPetsFavouriteIcon(),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  )
                ),

                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          _OngoingEventsSection(),
                          _SeeAllButton(),
                        ],
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _OngoingEventsBox(),
                            _OngoingEventsBox2()
                          ],
                        )
                      )
                    ]
                  )
                ),
              ],
            )
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
class _OngoingEventsBox2 extends StatelessWidget {
  const _OngoingEventsBox2();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xfff5f5f7),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(3, 4),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text("Giving foods",
                                  style: TextStyle(
                                      color: Color(0xff212121),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  )
                              )
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 15),
                          child: FittedBox(
                              child: Text("Ben",
                                  style: TextStyle(
                                    color: Color(0xff212121),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )
                              )
                          )
                      )
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text("9:00 AM, Today",
                                  style: TextStyle(
                                    color: Color(0xff212121),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )
                              )
                          )
                      ),

                      _EditButton()
                    ],
                  )
                ],
              )
          )
      ),
    );
  }
}

class _OngoingEventsBox extends StatelessWidget {
  const _OngoingEventsBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xfff5f5f7),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(3, 4),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text("Giving pills",
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        )
                      )
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 15),
                    child: FittedBox(
                      child: Text("Ben",
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      )
                    )
                  )
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text("8:00 AM, Today",
                              style: TextStyle(
                                color: Color(0xff212121),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )
                          )
                      )
                  ),

                  _EditButton()
                ],
              )
            ],
          )
        )
      ),
    );
  }
}

class _OngoingEventsSection extends StatelessWidget {
  const _OngoingEventsSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text('Ongoing events',
            style: TextStyle(
                color: Color(0xff212121),
                fontSize: 18,
                fontWeight: FontWeight.w500
            )))
    );
  }
}

class _YourPetsSection extends StatelessWidget {
  const _YourPetsSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text('Your pets',
          style: TextStyle(
            color: Color(0xff212121),
            fontSize: 18,
            fontWeight: FontWeight.w500
          )))
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  const _SeeAllButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2.5, 8, 0),
      child: FittedBox(
        child: TextButton(
          onPressed: () {},
          child: const Text('See all',
              style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.underline,
          )),),),
    );
  }
}

class _YourPetsFavouriteIcon extends StatelessWidget {
  const _YourPetsFavouriteIcon();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: IconButton(
            onPressed: () {},
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
            icon: const Icon(
              Icons.favorite,
              size: 21,
              color: Color(0xff212121),
            ))
    );
  }
}

class _YourPetsLabel extends StatelessWidget {
  const _YourPetsLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(13, 5, 8, 0),
      child: FittedBox(
        child: Text("Ben",
          style: TextStyle(
            color: Color(0xff212121),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )))
    );
  }
}

class _YourPetsSubLabel extends StatelessWidget {
  const _YourPetsSubLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
       padding: EdgeInsets.fromLTRB(13, 5, 8, 10),
       child: FittedBox(
           child: Text("Dog",
               style: TextStyle(
                 color: Color(0xff212121),
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
               )))
                                        );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 0, 8),
      child: Expanded(
        child: MaterialButton(
          onPressed: () {},
          elevation: 0,
          color: const Color(0xFF0051FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text("Edit",
                style: TextStyle(
                  color: Color(0xfff5f5f7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
            )
          ),
        )
      )
    );
  }
}

class _WelcomeBackSubLabel extends StatelessWidget {
  const _WelcomeBackSubLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: FittedBox(
        child: Text("Let's see how are your pets doing!",
          style: TextStyle(
            color: Color.fromARGB(255, 80, 80, 80),
            fontSize: 13,
            fontWeight: FontWeight.w300
          ),),),
    );
  }
}

class _WelcomeBackLabel extends StatelessWidget {
  const _WelcomeBackLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text('Welcome back 👋',
          style: TextStyle(
            color: Color(0xff212121),
            fontSize: 20,
            fontWeight: FontWeight.w500,
        )))
    );
  }
}







      