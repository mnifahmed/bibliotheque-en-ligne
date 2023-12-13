import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  bool get isDarkModeEnabled => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = isDarkModeEnabled ? ThemeMode.light : ThemeMode.dark;
  }
}
