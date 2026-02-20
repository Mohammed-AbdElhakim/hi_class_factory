import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/failure_handler.dart';
import '../../../../../core/errors/unknown_failure.dart';
import '../../../../../core/firebase/firebase_service.dart';
import '../../models/fabric_stock_model.dart';
import 'fabric_stock_repo.dart';

final String parentCollection = "warehouses";
final String parentDocId = "warehouse4_fabric";
final String subCollection = "fabric_stock";

class FabricStockRepoImpl implements FabricStockRepo {
  final FirebaseService firebaseService;

  FabricStockRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, Unit>> addFabricStock({
    required FabricStockModel fabricStockModel,
  }) async {
    try {
      await firebaseService.addSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        data: fabricStockModel.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFabricStock({required String id}) async {
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
  Future<Either<Failure, List<FabricStockModel>>> getFabricStock() async {
    try {
      final snapshot = await firebaseService.getAllSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
      );

      final products = snapshot.docs
          .map((doc) => FabricStockModel.fromMap(doc.data()))
          .toList();

      return right(products);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateFabricStock({
    required FabricStockModel fabricStockModel,
  }) async {
    try {
      await firebaseService.updateSubData(
        parentCollection: parentCollection,
        parentDocId: parentDocId,
        subCollection: subCollection,
        docId: fabricStockModel.id,
        data: fabricStockModel.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
