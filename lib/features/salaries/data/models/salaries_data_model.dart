import '../../../attendance/data/models/attendance_model.dart';
import '../../../employee/data/models/employee_model.dart';

class SalariesDataModel {
  final List<EmployeeModel> employeesList;
  final List<AttendanceModel> attendanceList;

  SalariesDataModel({required this.employeesList, required this.attendanceList});
}
