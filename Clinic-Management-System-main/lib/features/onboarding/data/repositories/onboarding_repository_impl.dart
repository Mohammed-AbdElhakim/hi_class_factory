import 'package:injectable/injectable.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasource/onboarding_local_data_source.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepositoryImpl(this._localDataSource);

  @override
  Future<void> completeOnboarding() async {
    await _localDataSource.saveOnboardingCompleted();
  }
}
