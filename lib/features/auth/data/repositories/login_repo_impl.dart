import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/firebase/firebase_service.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/firebase_failure.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../models/login_model.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final FirebaseService firebaseService;

  LoginRepoImpl(this.firebaseService);

  @override
  Future<Either<Failure, LoginModel>> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseService.login(
        username: username,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        return Left(
          FirebaseFailure(errorMessage: "User not found", type: FailureType.unauthorized),
        );
      }

      return Right(LoginModel.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
