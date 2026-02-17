import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';
import 'package:hi_class_factory/features/finishedProducts/data/models/product_model.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import 'finished_products_repo.dart';

class FinishedProductsRepoImpl implements FinishedProductsRepo {
  final FirebaseService firebaseService;

  FinishedProductsRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, Unit>> addFinishedProduct({
    required ProductModel product,
  }) async {
    try {
      // await firebaseService.addData(
      //   collection: "finished_products",
      //   data: product.toMap(),
      // );

      await firebaseService.addSubData(
        parentCollection: "warehouses",
        parentDocId: "warehouse1_finished_products",
        subCollection: "finished_products",
        data: product.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFinishedProduct({required String id}) async {
    try {
      // await firebaseService.delete(collection: "finished_products", docId: id);
      await firebaseService.deleteSubData(
        parentCollection: 'warehouses',
        parentDocId: "warehouse1_finished_products",
        subCollection: "finished_products",
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
  Future<Either<Failure, List<ProductModel>>> getFinishedProducts() async {
    try {
      // final snapshot = await firebaseService.getAll(collection: "finished_products");
      final snapshot = await firebaseService.getAllSubData(
        parentCollection: 'warehouses',
        parentDocId: "warehouse1_finished_products",
        subCollection: 'finished_products',
      );

      final products = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();

      return right(products);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateFinishedProduct({
    required ProductModel product,
  }) async {
    try {
      await firebaseService.updateSubData(
        parentCollection: 'warehouses',
        parentDocId: "warehouse1_finished_products",
        subCollection: 'finished_products',
        docId: product.id,
        data: product.toMap(),
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
