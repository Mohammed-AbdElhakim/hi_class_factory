import 'package:injectable/injectable.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_data_source.dart';


@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<HomeData> getHomeData() async {
    final response = await _remoteDataSource.getHomeData();
    return response.toDomain();
  }
}
