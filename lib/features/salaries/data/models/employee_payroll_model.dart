class EmployeePayrollModel {
  final String employeeId;
  final String employeeName;
  final double basicSalary;
  final int attendanceDays;
  final int absenceDays;
  final double overtimeHours;
  final double bonus;
  final double deductions;
  final double netSalary;

  EmployeePayrollModel({
    required this.employeeId,
    required this.employeeName,
    required this.basicSalary,
    required this.attendanceDays,
    required this.absenceDays,
    required this.overtimeHours,
    required this.bonus,
    required this.deductions,
    required this.netSalary,
  });

  factory EmployeePayrollModel.fromJson(Map<String, dynamic> json) =>
      EmployeePayrollModel(
        employeeId: json['employeeId'],
        employeeName: json['employeeName'],
        basicSalary: (json['basicSalary'] as num).toDouble(),
        attendanceDays: json['attendanceDays'],
        absenceDays: json['absenceDays'],
        overtimeHours: (json['overtimeHours'] as num).toDouble(),
        bonus: (json['bonus'] as num).toDouble(),
        deductions: (json['deductions'] as num).toDouble(),
        netSalary: (json['netSalary'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    'employeeId': employeeId,
    'employeeName': employeeName,
    'basicSalary': basicSalary,
    'attendanceDays': attendanceDays,
    'absenceDays': absenceDays,
    'overtimeHours': overtimeHours,
    'bonus': bonus,
    'deductions': deductions,
    'netSalary': netSalary,
  };
}
