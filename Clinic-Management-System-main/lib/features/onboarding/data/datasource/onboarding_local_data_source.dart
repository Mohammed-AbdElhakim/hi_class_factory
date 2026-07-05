import 'package:injectable/injectable.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/app_keys.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveOnboardingCompleted();
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final LocalStorage _localStorage;

  OnboardingLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> saveOnboardingCompleted() async {
    await _localStorage.setBool(AppKeys.isOnboardingCompleted, true);
  }
}
