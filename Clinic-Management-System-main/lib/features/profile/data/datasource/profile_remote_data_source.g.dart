// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ProfileRemoteDataSource implements ProfileRemoteDataSource {
  _ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<ProfileResponseModel> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProfileResponseModel>(
      Options(
        method: 'GET',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            ApiEndpoints.userProfile,
            queryParameters: queryParameters,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    ));
    late ProfileResponseModel _value;
    try {
      _value = ProfileResponseModel.fromJson(_result.data!);
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
      if (T == ProfileResponseModel) {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
