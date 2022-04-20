import 'package:flutter/material.dart';

class Style {

  String font = "AbrilFatface";
  String font2 = "Roboto";

  logoStyle({
    required double size,
    required FontWeight w,
    required Color color,
  }) {
    return TextStyle(
        fontSize: size,
        fontWeight: w,
        color: color,
        fontFamily: font
    );
  }

  textStyle({
    required double size,
    required FontWeight w,
    required Color color,
  }) {
    return TextStyle(
        fontSize: size,
        fontWeight: w,
        color: color,
        fontFamily: font2
    );
  }
}
