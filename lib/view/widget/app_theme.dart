import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'MPLUSRounded1c',
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'MPLUSRounded1c',
          fontSize: 20,
        ),
      ),
      useMaterial3: true,
    );
  }
}
