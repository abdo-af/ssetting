abstract class SettingsRepository {
  Future<bool> getTheme();
  Future<void> setTheme(bool isDark);
}
