import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../../../finishedProducts/data/models/product_model.dart';
import 'invoices_repo.dart';

class InvoicesRepoImpl implements InvoicesRepo {
  final FirebaseService firebaseService;

  InvoicesRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
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
}
