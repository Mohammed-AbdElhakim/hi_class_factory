import 'package:dartz/dartz.dart';

abstract class PayrollRepo {
  Future<Either<String, void>> generateWeeklyPayroll({
    required DateTime fromDate,
    required DateTime toDate,
  });
}
