import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF1F5F9),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF304C62),
      secondary: Color(0xFF64748B),
      surface: Color(0xFFFFFFFF),
      error: Color(0xFFDC2626),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor:  Color(0xFF304C62),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0F172A),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF60A5FA),
      secondary: Color(0xFF94A3B8),
      surface: Color(0xFF1E293B),
      error: Color(0xFFF87171),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF334155), width: 0.5),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF020617),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
