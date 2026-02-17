import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/accessories_model.dart';

abstract class AccessoriesRepo {
  Future<Either<Failure, Unit>> addAccessories({required AccessoriesModel accessory});

  Future<Either<Failure, Unit>> updateAccessories({required AccessoriesModel accessory});

  Future<Either<Failure, Unit>> deleteAccessories({required String id});

  Future<Either<Failure, List<AccessoriesModel>>> getAccessories();
}
