// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthRemoteDataSource implements AuthRemoteDataSource {
  _AuthRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<UserModel> login(LoginRequestModel request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(
      Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            ApiEndpoints.login,
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    ));
    late UserModel _value;
    try {
      _value = UserModel.fromJson(_result.data!);
    } catch (e, st) {
      throw DioException(
        requestOptions: _result.requestOptions,
        response: _result,
        type: DioExceptionType.unknown,
        error: e,
        stackTrace: st,
      );
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != String &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == UserModel) {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
