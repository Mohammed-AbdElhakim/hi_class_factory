import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/attendance_model.dart';
import '../models/attendance_record_model.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, Unit>> deleteAttendancePeriod({required String periodId});

  Future<Either<Failure, List<AttendanceModel>>> getAttendancePeriods();

  Future<Either<Failure, List<AttendanceRecordModel>>> getAttendanceRecords({
    required String periodId,
  });
}
