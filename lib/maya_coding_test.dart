import 'package:flutter/material.dart';
import 'package:maya_coding_test/config/theme.dart';
import 'package:maya_coding_test/presentation/screens/splash_screen.dart';

class MayaCodingTest extends StatelessWidget {
  const MayaCodingTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.main,
      home: SplashScreen(),
    );
  }
}
