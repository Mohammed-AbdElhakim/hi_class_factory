import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/home_response_model.dart';

part 'home_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class HomeRemoteDataSource {
  @factoryMethod
  factory HomeRemoteDataSource(Dio dio) = _HomeRemoteDataSource;

  @GET('/home/data')
  Future<HomeResponseModel> getHomeData();
}
