import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../models/profile_model.dart';
import 'profile_repo.dart';

final String collectionName = "settings";
final String documentName = "profile_info";

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, Unit>> saveProfile({required ProfileModel profile}) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseService.collectionMain)
          .doc(FirebaseService.factoryId)
          .collection(collectionName)
          .doc(documentName)
          .set(profile.toJson());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> getProfile() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(FirebaseService.collectionMain)
          .doc(FirebaseService.factoryId)
          .collection(collectionName)
          .doc(documentName)
          .get();
      if (doc.exists) {
        return right(ProfileModel.fromJson(doc.data()!));
      }

      return right(null);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
