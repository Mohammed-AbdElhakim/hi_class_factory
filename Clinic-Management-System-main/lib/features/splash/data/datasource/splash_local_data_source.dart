import 'package:injectable/injectable.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/app_keys.dart';

abstract class SplashLocalDataSource {
  Future<bool> isUserLoggedIn();
  Future<bool> isOnboardingCompleted();
}

@LazySingleton(as: SplashLocalDataSource)
class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final LocalStorage _localStorage;

  SplashLocalDataSourceImpl(this._localStorage);

  @override
  Future<bool> isUserLoggedIn() async {
    final token = _localStorage.getString(AppKeys.userToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _localStorage.getBool(AppKeys.isOnboardingCompleted) ?? false;
  }
}
