import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/employee/data/models/employee_model.dart';

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
            InfoRow(title: "الرقم القومي", value: employeeModel.nationalIDNumber),
            InfoRow(title: "كود الموظف", value: employeeModel.acNo),
            InfoRow(title: "الوظيفة", value: employeeModel.jobTitle),
            InfoRow(title: "رقم الهاتف", value: employeeModel.phone),
            InfoRow(
              title: "المرتب الشهري",
              value: employeeModel.monthlySalary.toString(),
            ),
            InfoRow(
              title: "طريقة القبض",
              value: employeeModel.paymentMethod == PaymentMethod.monthly
                  ? "قبض شهري"
                  : employeeModel.paymentMethod == PaymentMethod.weekly
                  ? "قبض اسبوعى كامل"
                  : "سلفة أسبوعية",
            ),
            if (employeeModel.paymentMethod == PaymentMethod.weeklyAdvance)
              InfoRow(
                title: "قيمة السلفة الأسبوعية",
                value: employeeModel.weeklyAdvanceAmount.toString(),
              ),
            InfoRow(
              title: "حالة الموظف",
              value: employeeModel.isActive ? "يعمل" : "متوقف عن العمل",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
