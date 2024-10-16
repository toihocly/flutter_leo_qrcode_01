import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
      primary: Color(0xFF212121),
      onPrimary: Colors.white,
      secondary: Color(0xFF757575),
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Color(0xFF212121),
      surface: Color(0xff1976D2),
      onSurface: Colors.white
      // brightness: Brightness.dark,
      ),
  dividerColor: Color(0xFFBDBDBD),
  snackBarTheme: const SnackBarThemeData(
      actionTextColor: Colors.red,
      backgroundColor: Color(0xFF757575),
      contentTextStyle: TextStyle(color: Colors.white),
      elevation: 20),
);
