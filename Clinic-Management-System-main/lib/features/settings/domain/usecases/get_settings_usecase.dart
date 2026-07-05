import 'package:injectable/injectable.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

@lazySingleton
class GetSettingsUsecase {
  final SettingsRepository _repository;

  GetSettingsUsecase(this._repository);

  Future<AppSettings> execute() async {
    return await _repository.getSettings();
  }
}
