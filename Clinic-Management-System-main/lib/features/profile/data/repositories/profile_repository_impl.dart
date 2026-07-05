import 'package:injectable/injectable.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';


@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    return response.toDomain();
  }
}
