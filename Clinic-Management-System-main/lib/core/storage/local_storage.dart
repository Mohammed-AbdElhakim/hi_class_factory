import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<bool> setString(String key, String value);
  String? getString(String key);
  Future<bool> setBool(String key, bool value);
  bool? getBool(String key);
  Future<bool> remove(String key);
  Future<bool> clear();
}

@LazySingleton(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  LocalStorageImpl(this._sharedPreferences);

  @override
  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  @override
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
