import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/employee_model.dart';

abstract class EmployeeRepo {
  Future<Either<Failure, Unit>> addEmployee({required EmployeeModel employee});

  Future<Either<Failure, Unit>> updateEmployee({required EmployeeModel employee});

  Future<Either<Failure, Unit>> deleteEmployee({required String id});

  Future<Either<Failure, List<EmployeeModel>>> getEmployee();
}
