import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';

class Scene extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 411;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // mainwindow1CL (1:3)
        width: double.infinity,
        decoration: const BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogroupdoejXRa (L3KHCPmNw32cCDue9idoej)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 36.5*fem),
              padding: EdgeInsets.fromLTRB(12.63*fem, 13.75*fem, 12.5*fem, 12.75*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: const Color(0xffffe15d),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x3f000000),
                    offset: Offset(0*fem, -3*fem),
                    blurRadius: 7.5*fem,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // topbarmenum52 (3:7)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 356.13*fem, 4*fem),
                    width: 15.75*fem,
                    height: 10.5*fem,
                    child: Image.asset(
                      'assets/page-1/images/menu_FILL0_wght400_GRAD0_opsz48',
                      width: 15.75*fem,
                      height: 10.5*fem,
                    ),
                  ),
                  SizedBox(
                    // topbarnotificationsfRJ (3:5)
                    width: 8*fem,
                    height: 17.5*fem,
                    child: Image.asset(
                      'assets/page-1/images/topbarnotifications.png',
                      width: 14*fem,
                      height: 17.5*fem,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // welcomebacklabelzCg (1:139)
              margin: EdgeInsets.fromLTRB(21*fem, 0*fem, 0*fem, 0*fem),
              child: Text(
                'Welcome back,',
                style: SafeGoogleFont (
                  'SF Pro Display',
                  fontSize: 24*ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2575*ffem/fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
            Container(
              // autogrouppzm9rkg (L3KJBcd2tHgaorKHNXPzm9)
              padding: EdgeInsets.fromLTRB(10*fem, 9*fem, 0*fem, 47*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroupq5cfkbA (L3KHQ8vowjmrrSC9KSQ5cF)
                    margin: EdgeInsets.fromLTRB(11*fem, 0*fem, 324*fem, 30*fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // usernameH5J (1:140)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0*fem),
                          child: Text(
                            'Tom',
                            style: SafeGoogleFont (
                              'SF Pro Display',
                              fontSize: 24*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2575*ffem/fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Text(
                          // wavingemojiNsS (1:142)
                          '👋',
                          style: SafeGoogleFont (
                            'SF Pro Display',
                            fontSize: 24*ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.2575*ffem/fem,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // yourpetslabelHzQ (1:141)
                    margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 0*fem, 18.5*fem),
                    child: Text(
                      'Your pets',
                      style: SafeGoogleFont (
                        'SF Pro Display',
                        fontSize: 24*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2575*ffem/fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // petslistm8t (1:121)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 39.5*fem),
                    width: 643*fem,
                    height: 145*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupsfvu36Q (L3KJirDzJNPaJfo8ZZsfVu)
                          padding: EdgeInsets.fromLTRB(14*fem, 0*fem, 0*fem, 19.5*fem),
                          width: 145*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: const Color(0xffff8b8b),
                            borderRadius: BorderRadius.circular(25*fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // autogroupakgtL5W (L3KJuvjs3QDNDaX2LwAkGT)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 35*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // petavatarr3r (1:126)
                                      margin: EdgeInsets.fromLTRB(0*fem, 18*fem, 76*fem, 0*fem),
                                      width: 35*fem,
                                      height: 35*fem,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(17.5*fem),
                                        image: const DecorationImage (
                                          fit: BoxFit.cover,
                                          image: AssetImage (
                                            'assets/page-1/images/petavatar-bg-XcC.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // notification81N (1:138)
                                      width: 20*fem,
                                      height: 20*fem,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(10*fem),
                                        color: const Color(0xffff4949),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupefprrTA (L3KK3qgLzzfDaoKX3dEfPR)
                                margin: EdgeInsets.fromLTRB(3.5*fem, 0*fem, 0*fem, 0*fem),
                                width: 27*fem,
                                height: 37.5*fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // pettype9x4 (1:131)
                                      left: 3.5*fem,
                                      top: 19.5*fem,
                                      child: Center(
                                        child: Align(
                                          child: SizedBox(
                                            width: 23*fem,
                                            height: 18*fem,
                                            child: Text(
                                              'Dog',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Display',
                                                fontSize: 14*ffem,
                                                fontWeight: FontWeight.w300,
                                                height: 1.2575*ffem/fem,
                                                color: const Color(0xff212121),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // petnamedcL (1:130)
                                      left: 0*fem,
                                      top: 0*fem,
                                      child: Center(
                                        child: Align(
                                          child: SizedBox(
                                            width: 27*fem,
                                            height: 21*fem,
                                            child: Text(
                                              'Ben',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Display',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2575*ffem/fem,
                                                color: const Color(0xff212121),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 21*fem,
                        ),
                        
                        SizedBox(
                          width: 21*fem,
                        ),
                        
                        SizedBox(
                          width: 21*fem,
                        ),
                        Container(
                          // autogroupgbphVVS (L3KKqEYNf5xFwoVqBAgBPh)
                          width: 145*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: const Color(0xff99ffe0),
                            borderRadius: BorderRadius.circular(25*fem),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                // petavatar2EU (1:129)
                                left: 14*fem,
                                top: 18*fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 35*fem,
                                    height: 35*fem,
                                    child: Container(
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(17.5*fem),
                                        image: const DecorationImage (
                                          fit: BoxFit.cover,
                                          image: AssetImage (
                                            'assets/page-1/images/petavatar-bg-UbA.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // pettypeid6 (1:134)
                                left: 24*fem,
                                top: 107.5*fem,
                                child: Center(
                                  child: Align(
                                    child: SizedBox(
                                      width: 19*fem,
                                      height: 18*fem,
                                      child: Text(
                                        'Cat',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w300,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // petnamecTa (1:137)
                                left: 18.5*fem,
                                top: 88*fem,
                                child: Center(
                                  child: Align(
                                    child: SizedBox(
                                      width: 27*fem,
                                      height: 21*fem,
                                      child: Text(
                                        'Ben',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 16*ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroup5az1uSg (L3KHZdezJ3ugVVxLZU5aZ1)
                    margin: EdgeInsets.fromLTRB(14*fem, 0*fem, 21*fem, 27.5*fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // eventslabelqLL (1:150)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 166*fem, 0*fem),
                          child: Text(
                            'Ongoing events',
                            style: SafeGoogleFont (
                              'SF Pro Display',
                              fontSize: 24*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2575*ffem/fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Text(
                          // seealleventsbutton8qE (1:165)
                          'See all',
                          textAlign: TextAlign.right,
                          style: SafeGoogleFont (
                            'SF Pro Display',
                            fontSize: 16*ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2575*ffem/fem,
                            decoration: TextDecoration.underline,
                            color: const Color(0xff169cfd),
                            decorationColor: const Color(0xff169cfd),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // eventsstackrFS (1:155)
                    margin: EdgeInsets.fromLTRB(11*fem, 0*fem, 19*fem, 0*fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // eventgroupLRW (1:180)
                          margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 21*fem),
                          padding: EdgeInsets.fromLTRB(24*fem, 10*fem, 24*fem, 23*fem),
                          width: 370*fem,
                          decoration: BoxDecoration (
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(25*fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroupbkujpba (L3KLXdYjHeLLi2xZv4bkUj)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 13*fem),
                                width: double.infinity,
                                height: 41*fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      // eventnameLpp (1:170)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 161*fem, 3.5*fem),
                                      child: Text(
                                        'Take pills',
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // editeventbutton3jE (1:188)
                                      width: 83*fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(15*fem),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // editeventboxy76 (1:189)
                                            left: 0*fem,
                                            top: 4*fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 83*fem,
                                                height: 33*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(15*fem),
                                                    color: Color(0xff0093ff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // editeventbuttonlabel4eL (1:190)
                                            left: 29.5*fem,
                                            top: 11.5*fem,
                                            child: Center(
                                              child: Align(
                                                child: SizedBox(
                                                  width: 24*fem,
                                                  height: 18*fem,
                                                  child: Text(
                                                    'Edit',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Display',
                                                      fontSize: 14*ffem,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroupff5u9Qt (L3KLgNoA5pw21PDKrCFf5u)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 3*fem, 0*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // petoneventt7a (1:178)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 175*fem, 0*fem),
                                      child: Text(
                                        'Pet: Ben',
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 16*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // eventtimelabelPq2 (1:202)
                                      margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 0*fem),
                                      child: Text(
                                        '8:00 PM, Today',
                                        textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // eventgroupW8x (1:181)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(25*fem, 13*fem, 23*fem, 23*fem),
                          width: 370*fem,
                          decoration: BoxDecoration (
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(25*fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroupggbvyHS (L3KLz2xQF7MjnucVZYgGbV)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 10*fem),
                                width: double.infinity,
                                height: 41*fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // eventname55a (1:177)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 163*fem, 0*fem),
                                      child: Text(
                                        'Bath Ben',
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // editeventbuttonxv4 (1:187)
                                      width: 83*fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration (
                                        borderRadius: BorderRadius.circular(15*fem),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            // editeventboxuaQ (1:182)
                                            left: 0*fem,
                                            top: 4*fem,
                                            child: Align(
                                              child: SizedBox(
                                                width: 83*fem,
                                                height: 33*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(15*fem),
                                                    color: const Color(0xff0093ff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // editeventbuttonlabelCJc (1:183)
                                            left: 29.5*fem,
                                            top: 11.5*fem,
                                            child: Center(
                                              child: Align(
                                                child: SizedBox(
                                                  width: 24*fem,
                                                  height: 18*fem,
                                                  child: Text(
                                                    'Edit',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Display',
                                                      fontSize: 14*ffem,
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.2575*ffem/fem,
                                                      color: const Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // autogroup6acbsvY (L3KM8St3uTVgic5woW6acB)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // petoneventb5r (1:179)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 171*fem, 0*fem),
                                      child: Text(
                                        'Pet: Ben',
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 16*ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // eventtimelabelh8t (1:191)
                                      margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 0*fem),
                                      child: Text(
                                        '9:00 PM, Today',
                                        textAlign: TextAlign.right,
                                        style: SafeGoogleFont (
                                          'SF Pro Display',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2575*ffem/fem,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupafataCg (L3KHkJ1tcnf4SLx6j7afaT)
              width: double.infinity,
              height: 65*fem,
              decoration: BoxDecoration (
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x3f000000),
                    offset: Offset(0*fem, 10*fem),
                    blurRadius: 7.5*fem,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // addbuttonUJ4 (3:10)
                    padding: EdgeInsets.fromLTRB(58.5*fem, 19.75*fem, 58.5*fem, 8.5*fem),
                    width: 137*fem,
                    height: double.infinity,
                    decoration: const BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // vectormY4 (1:73)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3.25*fem),
                          width: 17.5*fem,
                          height: 17.5*fem,
                          child: Image.asset(
                            'assets/page-1/images/vector-Ukx.png',
                            width: 17.5*fem,
                            height: 17.5*fem,
                          ),
                        ),
                        Center(
                          // addbuttonlabels5J (1:74)
                          child: Text(
                            'Add',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'SF Pro Display',
                              fontSize: 12*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2575*ffem/fem,
                              color: const Color(0xffd9d9d9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // tipsbuttonni4 (3:9)
                    padding: EdgeInsets.fromLTRB(57.5*fem, 15*fem, 55*fem, 7.5*fem),
                    width: 137*fem,
                    height: double.infinity,
                    decoration: const BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // vectoruXn (1:78)
                          margin: EdgeInsets.fromLTRB(3.5*fem, 0*fem, 0*fem, 5.5*fem),
                          width: 21*fem,
                          height: 21*fem,
                          child: Image.asset(
                            'assets/page-1/images/vector-SzC.png',
                            width: 21*fem,
                            height: 21*fem,
                          ),
                        ),
                        Center(
                          // tipsbuttonlabel2cQ (1:75)
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2.5*fem, 0*fem),
                            child: Text(
                              'Tips',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont (
                                'SF Pro Display',
                                fontSize: 12*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2575*ffem/fem,
                                color: const Color(0xffd9d9d9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // accountbuttonYKr (3:8)
                    padding: EdgeInsets.fromLTRB(48*fem, 19.75*fem, 48*fem, 8.5*fem),
                    width: 137*fem,
                    height: double.infinity,
                    decoration: const BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // vectorFk4 (1:80)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3.25*fem),
                          width: 17.5*fem,
                          height: 17.5*fem,
                          child: Image.asset(
                            'assets/page-1/images/vector.png',
                            width: 17.5*fem,
                            height: 17.5*fem,
                          ),
                        ),
                        Center(
                          // accountbuttonlabelAME (1:76)
                          child: Text(
                            'Account',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'SF Pro Display',
                              fontSize: 12*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2575*ffem/fem,
                              color: const Color(0xffd9d9d9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          );
  }
}