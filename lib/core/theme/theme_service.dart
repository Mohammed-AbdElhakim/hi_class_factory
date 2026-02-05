import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String key = "theme_mode";

  Future<void> saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, mode == ThemeMode.light ? "light" : "dark");
  }

  Future<ThemeMode> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(key);

    if (mode == "dark") return ThemeMode.dark;
    return ThemeMode.light;
  }
}
