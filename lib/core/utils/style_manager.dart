//Function To Get Text Style

import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';

Divider divider({
  double height = 0,
  double indent = 0,
  double endIndent = 0,
  double thickness = .3,
  Color color = ColorManager.greyWidget,
}) {
  return Divider(
    endIndent: endIndent,
    indent: indent,
    height: height,
    thickness: thickness,
    color: color,
  );
}

TextStyle _getTextStyle(
    {double? fontSize, FontWeight? fontWeight, Color? color,double? letterSpacing}) {
  return TextStyle(
     fontFamily: FontManager.fontFamilyAR,
      fontSize: fontSize,
      letterSpacing:letterSpacing,
      fontWeight: fontWeight,

      color: color??ColorManager.textColor);
}

///Regular Style
TextStyle getRegularStyle(
    {double? fontSize = FontSize.s16,  Color? color}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWegihtManager.regular, color: color);
}

///Bold Style
TextStyle getBoldStyle(
    {double? fontSize = FontSize.s16,  Color? color,double? letterSpacing}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWegihtManager.bold, color: color,letterSpacing:letterSpacing);
}

///SemiBold Style
TextStyle getSemiBoldStyle(
    {double? fontSize = FontSize.s16, required Color? color}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWegihtManager.semiBold, color: color);
}

///Bold Style
TextStyle getMediumStyle(
    {double? fontSize = FontSize.s16,  Color? color,double? letterSpacing}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWegihtManager.medium, color: color,letterSpacing:letterSpacing);
}

///Light Style
TextStyle getLightStyle(
    {double? fontSize = FontSize.s16,  Color? color}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWegihtManager.light, color: color);
}

///Regular Style
TextStyle getPoppinsStyle(
    {double? fontSize = FontSize.s16, required Color? color,FontWeight? fontWeight}) {
  return
    TextStyle(
        fontFamily: FontManager.fontFamilyPoppins,
        fontSize: fontSize,
        // letterSpacing:letterSpacing,
         fontWeight: fontWeight,
        color: color
    );
}
