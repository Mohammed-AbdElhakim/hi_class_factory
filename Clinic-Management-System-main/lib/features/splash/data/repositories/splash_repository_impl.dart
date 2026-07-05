import 'package:injectable/injectable.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasource/splash_local_data_source.dart';

@LazySingleton(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource _localDataSource;

  SplashRepositoryImpl(this._localDataSource);

  @override
  Future<bool> isUserLoggedIn() async {
    return await _localDataSource.isUserLoggedIn();
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _localDataSource.isOnboardingCompleted();
  }
}
