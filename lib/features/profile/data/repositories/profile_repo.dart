import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, Unit>> saveProfile({required ProfileModel profile});

  Future<Either<Failure, ProfileModel?>> getProfile();
}
