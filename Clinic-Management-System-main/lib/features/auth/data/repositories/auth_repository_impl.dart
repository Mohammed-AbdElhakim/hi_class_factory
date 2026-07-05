import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/login_request_model.dart';


@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<User> login(String email, String password) async {
    final response = await _remoteDataSource.login(
      LoginRequestModel(email: email, password: password),
    );
    if (response.token != null) {
      await _localDataSource.saveToken(response.token!);
    }
    return response.toDomain();
  }

  @override
  Future<void> logout() async {
    await _localDataSource.deleteToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await _localDataSource.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await _localDataSource.getToken();
  }
}
