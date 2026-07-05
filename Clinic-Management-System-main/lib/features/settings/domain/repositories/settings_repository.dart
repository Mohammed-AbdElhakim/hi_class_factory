import '../entities/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> setLanguage(String languageCode);
  Future<void> setDarkMode(bool isDarkMode);
}
