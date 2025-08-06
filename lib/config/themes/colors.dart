import 'package:flutter/material.dart';

class MyColors {
  //deve ser um verde claro, que lembre a cor do ricky e martie
  static const background = Color.fromARGB(101, 68, 213, 71);

  static const amber = Colors.amber;

  static const white = Colors.white;
  static const black = Colors.black;
  //0CFFFD
  //245C6B
  static const mainA = Color(0xff0CFFFD);
  static const mainB = Color(0xff245C6B);
  static const mainC = Color(0xff297FFF);
  static const mainD = Color(0xff53DAE3);

  static const mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      mainA,
      mainB,
    ],
  );

  static const blackGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      neutral60,
      neutral60,
    ],
  );

  static const gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      mainD,
      mainC,
    ],
  );

  static const tertiary = Color(0xff6AADEB);

  static const primary = Color(0xff297FFF);
  static const primary100 = Color(0xff2772E2);

  static const secondary = Color(0xff53DAE3);
  static const secondary100 = Color(0xff56BEC6);

  static const danger = Color(0xffFF6969);
  static const danger50 = Color(0xffFF4646);
  static const danger100 = Color(0xffE42D2D);

  static const success = Color(0xff6FAC49);
  static const success50 = Color(0xffACE588);

  static const alert = Color(0xffEE8A2E);

  static const inputColor = Color(0xff292C2E);

  static const neutral100 = Color(0xff131415);
  static const neutral90 = Color(0xff1B1D20);
  static const neutral80 = Color(0xff212325);
  static const neutral70 = Color(0xff272B30);
  static const neutral60 = Color(0xff484D52);
  static const neutral50 = Color(0xff7C828A);
  static const neutral40 = Color(0xffA6AEBA);
  static const neutral35 = Color(0xffD2DBE7);
  static const neutral30 = Color(0xffF2F8FF);

  static final hover = Colors.white.withValues(alpha: 0.2);
}
