import 'package:flutter/material.dart';
import 'package:maya_coding_test/core/extensions/colors.dart';

class AppConstants {
  static const String apiBaseUrl = 'https://jsonplaceholder.typicode.com';
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  static const TextStyle titleStyle = TextStyle(
    fontSize: 35,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );

  static const TextStyle fieldLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle fieldStyle = TextStyle(
    fontSize: 13,
  );
  static TextStyle hintStyle = TextStyle(
    fontSize: 13,
    color: Colors.white.withNewOpacity(.4),
  );
}
