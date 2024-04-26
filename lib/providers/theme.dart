import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  Color _currentSeedColor = Colors.amber;
  Color get currentSeedColor => _currentSeedColor;
  set currentSeedColor(Color newValue) {
    _currentSeedColor = newValue;
    notifyListeners();
  }

  set isDarkTheme(ThemeMode newValue) {
    _themeMode = newValue;
    notifyListeners();
  }

  void toggle() {
    if (themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  void changeSeedColor(Color color) {
    _currentSeedColor = color;
    notifyListeners();
  }
}
