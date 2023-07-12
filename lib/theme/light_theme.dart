import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Colors.white, secondary: Colors.grey, background: Colors.grey),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.black)));
