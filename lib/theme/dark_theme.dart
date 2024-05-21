import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Rubik',
  primaryColor: Color(0xFFDB1E34),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF2C2C2C),
  hintColor: Color(0xFFE7F6F8),
  focusColor: Color(0xFFADC4C8),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: Colors.white, textStyle: TextStyle(color: Colors.white),
  )),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Color(0xFF252525)),
    displayLarge: TextStyle(
        fontWeight: FontWeight.w300, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    displayMedium: TextStyle(
        fontWeight: FontWeight.w400, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    displaySmall: TextStyle(
        fontWeight: FontWeight.w500, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.w600, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    titleLarge: TextStyle(
        fontWeight: FontWeight.w800, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    bodySmall: TextStyle(
        fontWeight: FontWeight.w900, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 12.0),
    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
      .copyWith(secondary: Color(0xFF252525)),
);
