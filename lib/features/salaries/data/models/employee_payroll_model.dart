import 'package:hi_class_factory/features/employee/data/models/employee_model.dart';

import '../services/salary_result.dart';

class EmployeePayrollModel {
  final String employeeId;
  final String employeeName;
  final double basicSalary;
  final EmployeeModel employeeData;
  final SalaryResult salaryResult;

  EmployeePayrollModel({
    required this.employeeId,
    required this.employeeName,
    required this.basicSalary,
    required this.employeeData,
    required this.salaryResult,
  });

  factory EmployeePayrollModel.fromJson(Map<String, dynamic> json) =>
      EmployeePayrollModel(
        employeeId: json['employeeId'],
        employeeName: json['employeeName'],
        basicSalary: (json['basicSalary'] as num).toDouble(),
        employeeData: json['employeeData'] != null
            ? EmployeeModel.fromJson(json['employeeData'] as Map<String, dynamic>)
            : EmployeeModel(
                id: "",
                name: "",
                nationalIDNumber: "",
                jobTitle: "",
                phone: "",
                acNo: "",
                basicSalary: 0,
                monthlySalary: 0,
                yearlySalary: 0,
                paymentMethod: PaymentMethod.weeklyAdvance,
                hireDate: DateTime.now(),
                isActive: false,
              ),
        salaryResult: json['salaryResult'] != null
            ? SalaryResult.fromJson(json['salaryResult'] as Map<String, dynamic>)
            : SalaryResult(
                basicSalary: 0,
                salaryWeek: 0,
                monthlySalary: 0,
                yearlySalary: 0,
                totalSalary: 0,
                finalSalary: 0,
                totalAbsentDays: 0,
                absentDeduction: 0,
                totalLate: Duration.zero,
                lateDeduction: 0,
                totalOvertime: Duration.zero,
                overtimeAmount: 0,
                totalWorkedDays: 0,
                grossSalary: 0,
              ),
      );

  Map<String, dynamic> toJson() => {
    'employeeId': employeeId,
    'employeeName': employeeName,
    'basicSalary': basicSalary,
    'employeeData': employeeData.toJson(),
    'salaryResult': salaryResult.toJson(),
  };
}
