import 'package:flutter/material.dart';

class AppTheme {
  final Color? primaryColor;

  const AppTheme({
    this.primaryColor,
  });

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor ?? Colors.deepPurple,
        brightness: Brightness.light,
      ),
      // primaryColor: Colors.deepPurple,
      // scaffoldBackgroundColor: Colors.white,
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.deepPurple,
      // ),
    );
  }
}
