import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFAF3E1),
  primaryColor: const Color(0xFFFF6D1F),
  colorScheme: const ColorScheme.light(
      surface: Color(0xFFFAF3E1),
      tertiary: Color(0xFFFAF3E1),
      inverseSurface: Color(0xFF111111),
      primary: Color(0xFFFF6D1F),
      secondary: Color(0xFFF5E7C6)),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF111111),
  primaryColor: const Color(0xFFFAF3E1),
  colorScheme: const ColorScheme.dark(
      surface: Color(0xFF111111),
      tertiary: Color(0xFF343a40),
      inverseSurface: Color(0xFFFAF3E1),
      primary: Color(0xFFFF6D1F),
      secondary: Color(0xFFF5E7C6)),
);
