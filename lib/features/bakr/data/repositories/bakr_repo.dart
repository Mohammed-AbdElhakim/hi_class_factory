import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/bakr_model.dart';

abstract class BakrRepo {
  Future<Either<Failure, Unit>> addBakr({required BakrModel bakr});

  Future<Either<Failure, Unit>> updateBakr({required BakrModel bakr});

  Future<Either<Failure, Unit>> deleteBakr({required String id});

  Future<Either<Failure, List<BakrModel>>> getBakr();
}
