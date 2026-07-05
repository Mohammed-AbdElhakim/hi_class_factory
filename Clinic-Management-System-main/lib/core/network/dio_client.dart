import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../config/app_config.dart';

@lazySingleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = AppConfig.baseUrl
      ..options.connectTimeout = const Duration(milliseconds: AppConfig.connectTimeout)
      ..options.receiveTimeout = const Duration(milliseconds: AppConfig.receiveTimeout)
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    
    // Add default interceptors
    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;
}
