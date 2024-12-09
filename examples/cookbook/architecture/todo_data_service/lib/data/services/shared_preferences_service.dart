import 'package:shared_preferences/shared_preferences.dart';

// #docregion SharedPreferencesService
class SharedPreferencesService {
  static const String _kDartMode = 'darkMode';

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDartMode, value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kDartMode) ?? false;
  }
}
// #enddocregion SharedPreferencesService
