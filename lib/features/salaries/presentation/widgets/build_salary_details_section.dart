import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../../employee/data/models/employee_model.dart';
import '../../data/models/employee_payroll_model.dart';
import 'build_salary_row.dart';

class BuildSalaryDetailsSection extends StatelessWidget {
  const BuildSalaryDetailsSection({super.key, required this.employeeData});
  final EmployeePayrollModel employeeData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Header
          Row(
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              Text(
                S.of(context).salariesDetails,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 32),

          // المرتب الاساسى
          BuildSalaryRow(
            label: S.of(context).basicSalary2,
            amount: employeeData.salaryResult.basicSalary.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),

          //طريقه القبض
          BuildSalaryRow(
            label: S.of(context).paymentMethod,
            amount: employeeData.employeeData.paymentMethod == PaymentMethod.monthly
                ? S.of(context).monthlySalary
                : employeeData.employeeData.paymentMethod == PaymentMethod.weekly
                ? S.of(context).weeklySalary
                : S.of(context).weeklyAdvance,
            currency: "",
          ),
          const SizedBox(height: 12),

          // أيام الحضور
          BuildSalaryRow(
            label: S.of(context).attendanceDays,
            amount: employeeData.salaryResult.totalWorkedDays.toString(),
            currency: "",
          ),
          const SizedBox(height: 12),

          //وقت الأوفر تايم
          BuildSalaryRow(
            label: S.of(context).overtime,
            amount: formatDuration(employeeData.salaryResult.totalOvertime),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  الاضافي
          BuildSalaryRow(
            label: S.of(context).overtimeAmount,
            amount: employeeData.salaryResult.overtimeAmount.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),
          // وقت التأخير
          BuildSalaryRow(
            label: S.of(context).lateTime,
            amount: formatDuration(employeeData.salaryResult.totalLate),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  خصم التأخير
          BuildSalaryRow(
            label: S.of(context).lateDeduction,
            amount: employeeData.salaryResult.lateDeduction.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),

          // أيام الغياب
          BuildSalaryRow(
            label: S.of(context).absentDays,
            amount: employeeData.salaryResult.totalAbsentDays.toString(),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  خصم الغياب
          BuildSalaryRow(
            label: S.of(context).absentDeduction,
            amount: employeeData.salaryResult.absentDeduction.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),
          //  مرتب الاسبوع
          BuildSalaryRow(
            label: S.of(context).weeklySalaryLabel,
            amount: employeeData.employeeData.monthlySalary.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),
          //  الباقى الشهرى
          BuildSalaryRow(
            label: S.of(context).monthlyBalance,
            amount: employeeData.employeeData.monthlySalary.toString(),
            currency: S.of(context).egp,
          ),
          const SizedBox(height: 12),
          // الباقى السنوي
          BuildSalaryRow(
            label: S.of(context).yearlyBalance,
            amount: employeeData.employeeData.yearlySalary.toString(),
            currency: S.of(context).egp,
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }
}
