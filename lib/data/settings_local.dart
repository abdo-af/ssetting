// lib/data/settings_local.dart
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocal {
  static const String keyDark = "isDarkMode";
  static const String keyImagePath = "user_image_path";

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyDark) ?? false;
  }

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDark, isDark);
  }

  Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyImagePath);
  }

  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyImagePath, path);
  }

  Future<void> clearImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyImagePath);
  }
}
