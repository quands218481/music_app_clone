import 'package:flutter/material.dart';

class ThemeAppConfig {
  static ThemeData get lightTheme => ThemeData(
      fontFamily: 'BeVietnamPro',
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        // titleLarge: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        // titleMedium: const TextStyle(
        //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        //       titleSmall: const TextStyle(
        //       color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          headline3: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          headline1: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),
          caption: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)));
  static ThemeData get darkTheme => ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
      scaffoldBackgroundColor: Colors.grey,
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white, fontSize: 30)));
}
