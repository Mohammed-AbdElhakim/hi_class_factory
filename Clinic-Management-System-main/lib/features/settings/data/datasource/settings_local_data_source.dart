import 'package:injectable/injectable.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/app_keys.dart';

abstract class SettingsLocalDataSource {
  Future<String> getLanguage();
  Future<void> setLanguage(String languageCode);
  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool isDarkMode);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final LocalStorage _localStorage;

  SettingsLocalDataSourceImpl(this._localStorage);

  @override
  Future<String> getLanguage() async {
    return _localStorage.getString(AppKeys.userLanguage) ?? 'en';
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _localStorage.setString(AppKeys.userLanguage, languageCode);
  }

  @override
  Future<bool> isDarkMode() async {
    return _localStorage.getBool(AppKeys.userTheme) ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await _localStorage.setBool(AppKeys.userTheme, isDarkMode);
  }
}
