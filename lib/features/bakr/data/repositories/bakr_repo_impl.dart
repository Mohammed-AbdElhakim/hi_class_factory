import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../models/bakr_model.dart';
import 'bakr_repo.dart';

final String parentCollection = "warehouses";
final String parentDocId = "warehouse3_bakr";
final String subCollection = "bakr";

class BakrRepoImpl implements BakrRepo {
  final FirebaseService firebaseService;

  BakrRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, Unit>> addBakr({required BakrModel bakr}) async {
    try {
      await firebaseService.addSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        data: bakr.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBakr({required String id}) async {
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
  Future<Either<Failure, List<BakrModel>>> getBakr() async {
    try {
      final snapshot = await firebaseService.getAllSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
      );

      final bakr = snapshot.docs.map((doc) => BakrModel.fromMap(doc.data())).toList();

      return right(bakr);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBakr({required BakrModel bakr}) async {
    try {
      await firebaseService.updateSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        docId: bakr.id,
        data: bakr.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
