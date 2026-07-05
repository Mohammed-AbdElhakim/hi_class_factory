import 'package:injectable/injectable.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_local_data_source.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<AppSettings> getSettings() async {
    final lang = await _localDataSource.getLanguage();
    final dark = await _localDataSource.isDarkMode();
    return AppSettings(languageCode: lang, isDarkMode: dark);
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _localDataSource.setLanguage(languageCode);
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await _localDataSource.setDarkMode(isDarkMode);
  }
}
