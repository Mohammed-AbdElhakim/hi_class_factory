import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/profile_response_model.dart';

part 'profile_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class ProfileRemoteDataSource {
  @factoryMethod
  factory ProfileRemoteDataSource(Dio dio) = _ProfileRemoteDataSource;

  @GET(ApiEndpoints.userProfile)
  Future<ProfileResponseModel> getProfile();
}
