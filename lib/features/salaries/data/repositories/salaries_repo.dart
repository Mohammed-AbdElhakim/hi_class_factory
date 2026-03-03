import 'package:dartz/dartz.dart';
import 'package:hi_class_factory/core/errors/failure.dart';

import '../../../attendance/data/models/attendance_record_model.dart';
import '../../../employee/data/models/employee_model.dart';
import '../models/payroll_details_model.dart';
import '../models/salaries_data_model.dart';

abstract class SalariesRepo {
  Future<Either<Failure, SalariesDataModel>> getAttendanceAndEmployees();
  Future<Either<String, PayrollDetailsModel>> getPayroll({required String payrollId});
  Future<Either<String, Unit>> payrollCalculator({
    required List<EmployeeModel> employeesList,
    required List<AttendanceRecordModel> attendanceRecord,
  });
  Future<Either<String, Unit>> savePayroll({required PayrollDetailsModel payrollDetails});
}
