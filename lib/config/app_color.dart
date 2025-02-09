import 'package:flutter/material.dart';

class AppColor {
  static final Color scaffoldColor = Color(0xFF1a2432);
  static final Color appbarColor = Color(0xFF101729);
  static const int _purpleValue = 0xFF845bff;
  static const Color grey = Color(0xFF344152);
  static const Color red = Color(0xFFf72860);
  static const MaterialColor purpleSwatch = MaterialColor(
    _purpleValue,
    <int, Color>{
      50: Color(0xFFEDE6FF), // Lightest
      100: Color(0xFFD1C2FF),
      200: Color(0xFFB08DFF),
      300: Color(0xFF9969FF),
      400: Color(0xFF8A52FF),
      500: Color(_purpleValue), // Main
      600: Color(0xFF7A53E6),
      700: Color(0xFF6A49CC),
      800: Color(0xFF5C3EB3),
      900: Color(0xFF452D80), // Darkest
    },
  );
}
