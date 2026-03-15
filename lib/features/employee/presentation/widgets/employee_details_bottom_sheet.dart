import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/employee/data/models/employee_model.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import 'info_row.dart';

class EmployeeDetailsBottomSheet extends StatelessWidget {
  const EmployeeDetailsBottomSheet({super.key, required this.employeeModel});
  final EmployeeModel employeeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                employeeModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff904A42),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InfoRow(
              title: S.of(context).nationalId,
              value: employeeModel.nationalIDNumber,
            ),
            InfoRow(title: S.of(context).employeeCode, value: employeeModel.acNo),
            InfoRow(title: S.of(context).jobTitle, value: employeeModel.jobTitle),
            InfoRow(title: S.of(context).phoneNumber, value: employeeModel.phone),
            InfoRow(
              title: S.of(context).basicSalary,
              value: employeeModel.basicSalary.toString(),
            ),
            InfoRow(
              title: S.of(context).paymentMethod,
              value: employeeModel.paymentMethod == PaymentMethod.monthly
                  ? S.of(context).monthlySalary
                  : employeeModel.paymentMethod == PaymentMethod.weekly
                  ? S.of(context).weeklySalary
                  : S.of(context).weeklyAdvance,
            ),
            if (employeeModel.paymentMethod == PaymentMethod.weeklyAdvance)
              InfoRow(
                title: S.of(context).weeklyAdvanceAmount,
                value: employeeModel.weeklyAdvanceAmount.toString(),
              ),
            if (employeeModel.paymentMethod == PaymentMethod.weeklyAdvance)
              InfoRow(
                title: S.of(context).remainingSalary,
                value: employeeModel.weeklyAdvanceMethod == WeeklyAdvanceMethod.monthly
                    ? S.of(context).monthly
                    : employeeModel.weeklyAdvanceMethod == WeeklyAdvanceMethod.yearly
                    ? S.of(context).yearly
                    : "",
              ),
            InfoRow(
              title: S.of(context).monthlyBalance,
              value: employeeModel.monthlySalary.toString(),
            ),
            InfoRow(
              title: S.of(context).yearlyBalance,
              value: employeeModel.yearlySalary.toString(),
            ),

            InfoRow(
              title: S.of(context).employeeStatus,
              value: employeeModel.isActive
                  ? S.of(context).active
                  : S.of(context).inactive,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
