import 'package:injectable/injectable.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetProfileUsecase {
  final ProfileRepository _repository;

  GetProfileUsecase(this._repository);

  Future<Profile> execute() async {
    return await _repository.getProfile();
  }
}
