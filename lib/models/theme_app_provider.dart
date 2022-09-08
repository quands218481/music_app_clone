import 'package:flutter/material.dart';

class ThemeAppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  void toggleThemMode() {
    _themeMode =
        (themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    notifyListeners();
  }
}