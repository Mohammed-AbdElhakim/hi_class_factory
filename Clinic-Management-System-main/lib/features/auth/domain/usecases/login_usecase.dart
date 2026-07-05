import 'package:injectable/injectable.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<User> execute(String email, String password) async {
    return await _repository.login(email, password);
  }
}
