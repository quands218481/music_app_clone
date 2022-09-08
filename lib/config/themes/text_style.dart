import 'package:flutter/material.dart';

class TxtStyle {
  static const heading1 =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 30, height: 1.2);
  static const heading2 = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.2,
      decoration: TextDecoration.none,
      color: Colors.white);
  static const heading3 =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 20, height: 1.2);
  static const heading4 = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.2,
      decoration: TextDecoration.none,
      color: Colors.white);

  static const heading1SemiBold = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );

  static const heading1Medium = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 30,
    height: 1.2,
  );
  static const heading3Medium = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 20,
      height: 1.2,
      decoration: TextDecoration.none,
      color: Colors.white);

  static const heading3Light = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 20,
      height: 1.2,
      color: Colors.white,
      decoration: TextDecoration.none);
  static const heading4Light = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 16,
      height: 1.2,
      color: Colors.white,
      decoration: TextDecoration.none);
}
