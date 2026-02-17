import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/product_model.dart';

abstract class FinishedProductsRepo {
  Future<Either<Failure, Unit>> addFinishedProduct({required ProductModel product});

  Future<Either<Failure, Unit>> updateFinishedProduct({required ProductModel product});

  Future<Either<Failure, Unit>> deleteFinishedProduct({required String id});

  Future<Either<Failure, List<ProductModel>>> getFinishedProducts();
}
