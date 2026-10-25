import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
ThemeMode themeMode = ThemeMode.light;

Future<void> loadTheme() async {
final prefs = await SharedPreferences.getInstance();
final savedMode = prefs.getBool('themeMode') ?? false;
themeMode = savedMode ? ThemeMode.dark : ThemeMode.light;
notifyListeners();
}

Future<void> changeTheme(ThemeMode newTheme) async {
if (themeMode == newTheme) return;

themeMode = newTheme;

final prefs = await SharedPreferences.getInstance();
await prefs.setBool(
'themeMode',
newTheme == ThemeMode.dark,
);

notifyListeners();
}
}
