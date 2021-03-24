import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle thin({Color color, double size = 12}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w200);
  }

  static TextStyle light({Color color, double size = 12}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w300);
  }

  static TextStyle regular({Color color, double size = 14}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w400);
  }

  static TextStyle medium({Color color, double size = 16}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w500);
  }

  static TextStyle bold({Color color, double size = 18}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w700);
  }

  static TextStyle black({Color color, double size = 20}) {
    return TextStyle(
        color: color,
        fontFamily: 'Cera Pro',
        fontSize: size,
        fontWeight: FontWeight.w900);
  }
}
