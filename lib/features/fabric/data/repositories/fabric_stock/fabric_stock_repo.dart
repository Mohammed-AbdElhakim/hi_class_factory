import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../models/fabric_stock_model.dart';

abstract class FabricStockRepo {
  Future<Either<Failure, Unit>> addFabricStock({
    required FabricStockModel fabricStockModel,
  });

  Future<Either<Failure, Unit>> updateFabricStock({
    required FabricStockModel fabricStockModel,
  });

  Future<Either<Failure, Unit>> deleteFabricStock({required String id});

  Future<Either<Failure, List<FabricStockModel>>> getFabricStock();
}
