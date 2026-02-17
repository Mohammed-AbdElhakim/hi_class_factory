import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../models/accessories_model.dart';
import 'accessories_repo.dart';

final String parentCollection = "warehouses";
final String parentDocId = "warehouse2_accessories";
final String subCollection = "accessories";

class AccessoriesRepoImpl implements AccessoriesRepo {
  final FirebaseService firebaseService;

  AccessoriesRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, Unit>> addAccessories({
    required AccessoriesModel accessory,
  }) async {
    try {
      await firebaseService.addSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        data: accessory.toJson(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccessories({required String id}) async {
    try {
      await firebaseService.deleteSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        docId: id,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<AccessoriesModel>>> getAccessories() async {
    try {
      final snapshot = await firebaseService.getAllSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
      );

      final products = snapshot.docs
          .map((doc) => AccessoriesModel.fromJson(doc.data()))
          .toList();

      return right(products);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAccessories({
    required AccessoriesModel accessory,
  }) async {
    try {
      await firebaseService.updateSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        docId: accessory.id,
        data: accessory.toJson(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
