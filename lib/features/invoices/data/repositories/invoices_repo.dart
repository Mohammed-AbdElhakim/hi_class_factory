import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../finishedProducts/data/models/product_model.dart';

abstract class InvoicesRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}
