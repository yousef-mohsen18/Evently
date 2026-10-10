import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =ThemeMode.dark;

  changeTheme(ThemeMode newTheme){
    if(themeMode==newTheme)return;
    themeMode = newTheme;
    notifyListeners();
  }
}