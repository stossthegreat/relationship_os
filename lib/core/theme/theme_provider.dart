import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey) ?? true; // Default to dark
      state = isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      // If loading fails, just stay with default dark mode
      state = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      await prefs.setBool(_themeKey, newMode == ThemeMode.dark);
      state = newMode;
    } catch (e) {
      // If toggle fails, just toggle in memory
      state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, mode == ThemeMode.dark);
      state = mode;
    } catch (e) {
      // If save fails, just set in memory
      state = mode;
    }
  }

  bool get isDark => state == ThemeMode.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

