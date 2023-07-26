import 'package:flutter/material.dart';

Color primaryColor = Colors.pink;

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
    ),
  ),
  cardTheme: const CardTheme(
    color: Color.fromARGB(134, 33, 33, 33),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.white,
  ),
);
