import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../attendance/data/models/attendance_record_model.dart';
import '../../../../employee/data/models/employee_model.dart';
import '../../../data/models/employee_payroll_model.dart';
import '../../../data/models/payroll_details_model.dart';
import '../../../data/models/payroll_model.dart';
import '../../../data/repositories/salaries_repo.dart';
import '../../../data/services/salary_calculator.dart';
import '../../../data/services/salary_result.dart';

part 'payroll_state.dart';

class PayrollCubit extends Cubit<PayrollState> {
  final SalariesRepo repo;

  PayrollCubit(this.repo) : super(PayrollInitial());

  Future<void> loadPayroll(String payrollId) async {
    emit(PayrollLoading());

    final result = await repo.getPayroll(payrollId: payrollId);

    result.fold((l) => emit(PayrollError(l)), (r) => emit(PayrollLoaded(r)));
  }

  Future<void> savePayroll({required PayrollDetailsModel payrollDetails}) async {
    emit(PayrollSaving());
    final result = await repo.savePayroll(payrollDetails: payrollDetails);

    result.fold((l) => emit(PayrollError(l)), (_) => emit(PayrollLoaded(payrollDetails)));
  }

  Future<void> calculatePayroll({
    required List<EmployeeModel> employeeList,
    required List<AttendanceRecordModel> attendanceList,
    required String payrollId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    emit(PayrollLoading());
    try {
      List<EmployeePayrollModel> employeePayrollList = [];
      for (var employee in employeeList) {
        List<AttendanceRecordModel> employeeAttendance = attendanceList
            .where((element) => element.acNo.toString() == employee.acNo)
            .toList();
        SalaryCalculator calculator = SalaryCalculator(
          basicSalary: employee.basicSalary,
          employee: employee,
        );
        SalaryResult salaryResult = calculator.calculateSalary(
          records: employeeAttendance,
        );
        //تعديل للبيانات الموظف عشان القبض
        EmployeeModel newEmployee = employee.copyWith(
          monthlySalary: salaryResult.monthlySalary,
          yearlySalary: salaryResult.yearlySalary,
        );
        final result = await repo.updateEmployee(employee: newEmployee);

        result.fold((l) => emit(PayrollError(l.errorMessage)), (r) {
          EmployeePayrollModel employeePayrollModel = EmployeePayrollModel(
            employeeId: employee.id,
            employeeName: employee.name,
            basicSalary: employee.basicSalary,
            employeeData: employee,
            salaryResult: salaryResult,
          );
          employeePayrollList.add(employeePayrollModel);
        });
      }
      double totalNet = employeePayrollList.fold(
        0.0,
        (previousValue, element) => previousValue + element.salaryResult.finalSalary,
      );
      PayrollModel payrollModel = PayrollModel(
        id: payrollId,
        startDate: fromDate,
        endDate: toDate,
        createdAt: DateTime.now(),
        totalNet: totalNet,
        employeesCount: employeePayrollList.length,
      );
      PayrollDetailsModel payrollDetailsModel = PayrollDetailsModel(
        payroll: payrollModel,
        employeesPayroll: employeePayrollList,
      );
      savePayroll(payrollDetails: payrollDetailsModel);
    } on Exception catch (e) {
      emit(PayrollError(e.toString()));
    }
  }
}
