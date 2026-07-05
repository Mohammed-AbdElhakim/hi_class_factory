import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/login_request_model.dart';
import '../models/user_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST(ApiEndpoints.login)
  Future<UserModel> login(@Body() LoginRequestModel request);
}
