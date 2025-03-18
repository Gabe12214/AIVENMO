import 'package:flutter/material.dart';

final ThemeData terminatorTheme = ThemeData(
  primaryColor: Color(0xFF212121),
  primaryColorDark: Color(0xFF000000),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFF5252)),
  // Updated accentColor
  backgroundColor: Color(0xFF303030),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFFE0E0E0),
      fontFamily: 'TerminatorFont',
    ),
    bodyText2: TextStyle(
      color: Color(0xFFE0E0E0),
      fontFamily: 'TerminatorFont',
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF212121),
    textTheme: ButtonTextTheme.primary,
  ),
);
