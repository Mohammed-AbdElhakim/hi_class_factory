import 'package:dartz/dartz.dart';
import 'package:hi_class_factory/core/errors/failure.dart';

import '../../../attendance/data/models/attendance_model.dart';

abstract class SalariesRepo {
  // Future<Either<String, void>> generateWeeklyPayroll({
  //   required DateTime fromDate,
  //   required DateTime toDate,
  // });

  Future<Either<Failure, List<AttendanceModel>>> getAttendance();
}
