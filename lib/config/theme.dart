import 'package:flutter/material.dart';
import 'package:maya_coding_test/core/extensions/colors.dart';
import 'package:maya_coding_test/config/app_color.dart';

class AppTheme {
  static final InputBorder _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: AppColor.purpleSwatch.shade600,
    ),
  );
  static final InputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppColor.red),
  );
  static ThemeData main = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColor.appbarColor,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white)),
    brightness: Brightness.dark,
    primaryColor: AppColor.appbarColor,
    scaffoldBackgroundColor: AppColor.scaffoldColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.grey.shade100,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey.shade100,
      ),
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColor.purpleSwatch,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.purpleSwatch.withNewOpacity(.1),
      border: _defaultBorder,
      enabledBorder: _defaultBorder,
      focusedBorder: _defaultBorder,
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
    ),
    fontFamily: "Poppins",
  );
}
