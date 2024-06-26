import 'package:flutter/material.dart';

class ColorManager{
  static const primary = Color(0xffFF7600);// اللون الاساسي
  static const secondary = Color(0xff108EF6);
  ///
  static const textColor = Color(0xff454545);
  static const textFieldColor = Color(0xffFFFFFF);
  static const textFieldHintColor = Color(0xff656565);
  static const shadowColor = Color(0x40000000);
  static const shadowLightColor = Color(0x1A000000);
  static const meterColor = Color(0xffB1B1B1);

   static const appBarColor = Color(0xffFAFAFA);
   // static const appBarColor = Color(0xffF3F3F3);

  ///--- Neutral
  static const black = Color(0xff000000);
  static const white = Color(0xffF3F3F3);
  static const grey = Color(0xffAAAAAA);
  static const red = Color(0xffFF4C4C);

  static const greyWidget= Color(0xffD9D9D9);
  static const redBright= Color(0xffFF4D00);//GrayLight (رمادي فاتح)
  static const  grayLight  = Color(0xffAAAAAA);//RedBright (أحمر مشرق)
  static const grayDark = Color(0xff454545);//GrayDark (رمادي داكن)
  static const orangeBright = Color(0xffFF6D00);//OrangeBright (برتقالي مشرق)
  static const orangeSunset = Color(0xffFF8412);//"OrangeSunset" (غروب الشمس البرتقالي)
  static const skyBlue = Color(0xffB6DEFF);
  // static const darkGrey = Color(0xff827D89);
  // static const lightGrey = Color(0xffEFEEF0);

  ///--- Scaffold BackGround
  static const scaffoldBackgroundLight = Color(0xffFAFAFA);
  // static const scaffoldBackgroundLight = Color(0xffF3F3F3);
  static const scaffoldBackgroundDark =  Color(0xff000000);
  ///--- Success
  static const success = Color(0xff4AC064);
  static const successDark = Color(0xff1F7F40);
  static const successLight = Color(0xffDAF6E4);
  ///--- Error
  static const error = Color(0xffFE6A60);
  static const errorDark = Color(0xff5A1623);
  static const errorLight = Color(0xffF7DEE3);
  ///--- Warning
  static const warning = Color(0xffFFC83C);
  static const warningDark = Color(0xff725A03);
  static const warningLight = Color(0xffFDEBAB);

  ///--- gradient
  static const Color startColor = Color(0xFFFF9A00);
  static const Color endColor = Color(0xFFFF4D00);
  static const Gradient myGradient = LinearGradient(
      colors: [startColor, endColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,);
  static final List<Color> gradientColors = [
  startColor, endColor,
  ];
///
}