import 'package:injectable/injectable.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/app_keys.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage _localStorage;

  AuthLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> saveToken(String token) async {
    await _localStorage.setString(AppKeys.userToken, token);
  }

  @override
  Future<String?> getToken() async {
    return _localStorage.getString(AppKeys.userToken);
  }

  @override
  Future<void> deleteToken() async {
    await _localStorage.remove(AppKeys.userToken);
  }
}
