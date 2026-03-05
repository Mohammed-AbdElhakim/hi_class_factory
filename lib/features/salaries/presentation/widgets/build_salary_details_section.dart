import 'package:flutter/material.dart';

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
              const Text(
                'تفصيل الراتب',
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
            label: 'الراتب الأساسي',
            amount: employeeData.salaryResult.basicSalary.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),

          //طريقه القبض
          BuildSalaryRow(
            label: 'طريقة القبض',
            amount: employeeData.employeeData.paymentMethod == PaymentMethod.monthly
                ? "قبض شهري"
                : employeeData.employeeData.paymentMethod == PaymentMethod.weekly
                ? "قبض اسبوعى كامل"
                : "سلفة أسبوعية",
            currency: "",
          ),
          const SizedBox(height: 12),

          // أيام الحضور
          BuildSalaryRow(
            label: "أيام الحضور",
            amount: employeeData.salaryResult.totalWorkedDays.toString(),
            currency: "",
          ),
          const SizedBox(height: 12),

          //وقت الأوفر تايم
          BuildSalaryRow(
            label: "الوقت الاضافى",
            amount: formatDuration(employeeData.salaryResult.totalOvertime),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  الاضافي
          BuildSalaryRow(
            label: "الأضافى",
            amount: employeeData.salaryResult.overtimeAmount.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),
          // وقت التأخير
          BuildSalaryRow(
            label: "وقت التاخير",
            amount: formatDuration(employeeData.salaryResult.totalLate),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  خصم التأخير
          BuildSalaryRow(
            label: "خصم التأخير",
            amount: employeeData.salaryResult.lateDeduction.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),

          // أيام الغياب
          BuildSalaryRow(
            label: "أيام الغياب",
            amount: employeeData.salaryResult.totalAbsentDays.toString(),
            currency: "",
          ),
          const SizedBox(height: 12),
          //  خصم الغياب
          BuildSalaryRow(
            label: "خصم الغياب",
            amount: employeeData.salaryResult.absentDeduction.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),
          //  مرتب الاسبوع
          BuildSalaryRow(
            label: 'مرتب الاسبوع',
            amount: employeeData.employeeData.monthlySalary.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),
          //  الباقى الشهرى
          BuildSalaryRow(
            label: 'الرصيد الشهرى',
            amount: employeeData.employeeData.monthlySalary.toString(),
            currency: "ج.م",
          ),
          const SizedBox(height: 12),
          // الباقى السنوي
          BuildSalaryRow(
            label: 'الرصيد السنوي',
            amount: employeeData.employeeData.yearlySalary.toString(),
            currency: "ج.م",
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
