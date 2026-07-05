import 'package:injectable/injectable.dart';
import '../repositories/onboarding_repository.dart';

@lazySingleton
class CompleteOnboardingUsecase {
  final OnboardingRepository _repository;

  CompleteOnboardingUsecase(this._repository);

  Future<void> execute() async {
    await _repository.completeOnboarding();
  }
}
