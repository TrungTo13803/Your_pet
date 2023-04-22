import 'package:demo/constrants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/views/notifications_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xfff5f5f7), body: _MainPageView());
  }
}

class _MainPageView extends StatelessWidget {
  const _MainPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 10, 20),
            child: FittedBox(
                child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(accountRoute, (route) => false);
              },
              icon: const Icon(
                Icons.account_circle,
                size: 24,
                color: Color(0xFF0f67ca),
              ),
            )),
          )
        ],
      ),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _WelcomeBackLabel(),
          ]),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
        child: Row(
          children: const [
            FittedBox(
              child: Text('Recent added pet',
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            )
          ],
        ),
      ),
      Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: FittedBox(
                                  child: Icon(
                                CupertinoIcons.paw,
                                size: 30,
                                color: Color(0xFF0f67ca),
                              ))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: FittedBox(
                                      child: Text("Your favorite pet",
                                          style: TextStyle(
                                              color: Color(0xff212121),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: FittedBox(
                                      child: Text(
                                          "Recently added pet will be displayed here",
                                          style: TextStyle(
                                              color: Color(0xff212121),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)))),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(petsListRoute);
                              },
                              child: const Text('See all',
                                  style: TextStyle(
                                    color: Color(0xFF0f67ca),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: FittedBox(
                                  child: Text(
                                    'Ongoing activity',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff434344),
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: FittedBox(
                                child: Icon(
                                  CupertinoIcons.calendar,
                                  size: 30,
                                  color: Color(0xFF0f67ca),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 20, 10, 10),
                                    child: FittedBox(
                                        child: Text("Keep track easily",
                                            style: TextStyle(
                                                color: Color(0xff212121),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: FittedBox(
                                        child: Text(
                                            "Recently added activity will be display here",
                                            style: TextStyle(
                                                color: Color(0xff212121),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400)))),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Show all',
                                    style: TextStyle(
                                      color: Color(0xFF0f67ca),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          )),
    ]));
  }
}

class _WelcomeBackLabel extends StatelessWidget {
  const _WelcomeBackLabel();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 8, 8),
                    child: FittedBox(
                        child: Text('Welcome back 👋',
                            style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 4, 8, 10),
                    child: FittedBox(
                      child: Text(
                        "Let's see how are your pets doing!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 80, 80, 80),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
