import 'package:dunki/theme/themedata.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themedata) {
    _themeData = themeData;
  }

  void toggleTheme() {
    debugPrint("Changing theme!");
    if (themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
