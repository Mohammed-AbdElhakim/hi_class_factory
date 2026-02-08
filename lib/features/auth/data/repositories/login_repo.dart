import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> loginUser({
    required String username,
    required String password,
  });
  Future<Either<Failure, void>> upDataUser({required UserModel userModel});
}
