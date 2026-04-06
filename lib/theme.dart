import 'package:flutter/material.dart';

class AppTheme {
  // الثيم الفاتح
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 50, 149, 195),
    scaffoldBackgroundColor: Color.fromARGB(255, 50, 149, 195),
    useMaterial3: true,
  );

  // الثيم الداكن
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 50, 149, 195),
    scaffoldBackgroundColor: Color.fromARGB(255, 50, 149, 195),
  );
}
