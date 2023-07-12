import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: const Color.fromARGB(255, 16, 3, 3),
        primary: Colors.grey[900]!,
        secondary: Colors.grey[800]!),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.white)));
