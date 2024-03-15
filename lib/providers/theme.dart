import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  set isDarkTheme(ThemeMode newValue) {
    _themeMode = newValue;
    notifyListeners();
  }

  void toggle() {
    switch (themeMode.index) {
      case 0: // System
        _themeMode = ThemeMode.light;
        break;
      case 1: // Light
        _themeMode = ThemeMode.dark;
        break;
      case 2: // Dark
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }
}
