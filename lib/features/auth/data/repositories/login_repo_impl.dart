import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/firebase/firebase_service.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/firebase_failure.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../models/user_model.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final FirebaseService firebaseService;

  LoginRepoImpl(this.firebaseService);

  @override
  Future<Either<Failure, UserModel>> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      // تسجيل الدخول عبر Firebase Auth
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

      // جلب بيانات المستخدم من Firestore

      // final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userDocSnapshot = await firebaseService.getById(
        collection: AppStrings.collectionUsers,
        docId: user.uid,
      );

      if (!userDocSnapshot.exists) {
        return Left(
          FirebaseFailure(
            errorMessage: "User document not found",
            type: FailureType.unknown,
          ),
        );
      }

      // تحويل البيانات لـ UserModel
      UserModel userModel = UserModel.fromJson(userDocSnapshot.data()!);

      // تحديث lastLogin
      final now = Timestamp.now();
      await firebaseService.updateData(
        collection: AppStrings.collectionUsers,
        docId: user.uid,
        data: {'lastLogin': now},
      );

      // تحديث الـ userModel بعد التعديل
      userModel = userModel.copyWith(lastLogin: now.toDate());

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> upDataUser({required UserModel userModel}) async {
    try {
      await firebaseService.updateData(
        collection: AppStrings.collectionUsers,
        docId: userModel.uid,
        data: userModel.toJson(),
      );

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
