import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
//import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';

class Opening extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 411;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: TextButton(
        // openingiiU (1:2)
        onPressed: () {},
        style: TextButton.styleFrom (
          padding: EdgeInsets.zero,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(102*fem, 276*fem, 103*fem, 94*fem),
          width: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // imgapplogofvY (1:10)
                margin: EdgeInsets.fromLTRB(30*fem, 0*fem, 30*fem, 31.5*fem),
                padding: EdgeInsets.fromLTRB(29.57*fem, 32.41*fem, 30.36*fem, 31.82*fem),
                width: double.infinity,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xff212121)),
                  color: Color(0xffffe15d),
                  borderRadius: BorderRadius.circular(73*fem),
                ),
                child: Center(
                  // openingpawiconuZz (1:9)
                  child: SizedBox(
                    width: 86.07*fem,
                    height: 81.77*fem,
                    child: Image.asset(
                      'assets/page-1/images/openingpawicon.png',
                      width: 86.07*fem,
                      height: 81.77*fem,
                    ),
                  ),
                ),
              ),
              Center(
                // appnameBGc (1:12)
                child: Container(
                  margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 85.5*fem),
                  child: Text(
                    'yourPet',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont (
                      'SF Pro Display',
                      fontSize: 30*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2575*ffem/fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Container(
                // autogroupvomuRRr (L3KGZFAcNNe9a6K8R3VoMu)
                width: double.infinity,
                height: 152*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // registerbuttonZHA (3:12)
                      left: 0*fem,
                      top: 75*fem,
                      child: Container(
                        width: 206*fem,
                        height: 77*fem,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(25*fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              // registerbuttonT7e (1:45)
                              left: 0*fem,
                              top: 7*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 206*fem,
                                  height: 63*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(25*fem),
                                      border: Border.all(color: Color(0xff212121)),
                                      color: Color(0xffffe15d),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // registerlabelnZE (1:49)
                              left: 61.5*fem,
                              top: 23*fem,
                              child: Center(
                                child: Align(
                                  child: SizedBox(
                                    width: 84*fem,
                                    height: 31*fem,
                                    child: Text(
                                      'Register',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'SF Pro Display',
                                        fontSize: 24*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // loginbuttonzvC (3:11)
                      left: 0*fem,
                      top: 0*fem,
                      child: Container(
                        width: 206*fem,
                        height: 77*fem,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(25*fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              // loginboxunG (1:44)
                              left: 0*fem,
                              top: 7*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 206*fem,
                                  height: 63*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(25*fem),
                                      border: Border.all(color: Color(0xff212121)),
                                      color: Color(0xffffe15d),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // loginlabelzoi (1:48)
                              left: 74.5*fem,
                              top: 23*fem,
                              child: Center(
                                child: Align(
                                  child: SizedBox(
                                    width: 58*fem,
                                    height: 31*fem,
                                    child: Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'SF Pro Display',
                                        fontSize: 24*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
          );
  }
}