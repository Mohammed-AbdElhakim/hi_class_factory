import 'employee_payroll_model.dart';
import 'payroll_model.dart';

class PayrollDetailsModel {
  final PayrollModel payroll;
  final List<EmployeePayrollModel> employeesPayroll;

  PayrollDetailsModel({required this.payroll, required this.employeesPayroll});
}
