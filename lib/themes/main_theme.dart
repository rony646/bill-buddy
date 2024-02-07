import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3078E3)),
  disabledColor: Color(0xD7DEDDDD),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: Color(0xFF3078E3),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  ),
);
