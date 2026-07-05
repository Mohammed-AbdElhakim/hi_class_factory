import 'package:injectable/injectable.dart';
import '../repositories/splash_repository.dart';

@lazySingleton
class CheckAuthStatusUsecase {
  final SplashRepository _repository;

  CheckAuthStatusUsecase(this._repository);

  Future<bool> execute() async {
    return await _repository.isUserLoggedIn();
  }
}
