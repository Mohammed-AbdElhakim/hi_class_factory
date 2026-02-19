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
          InfoRow(title: "الوظيفة", value: employeeModel.jobTitle),
          InfoRow(title: "رقم الهاتف", value: employeeModel.phone),
          InfoRow(title: "أيام الغياب", value: employeeModel.absentDays.toString()),
          InfoRow(title: "أيام التأخير", value: employeeModel.lateDays.toString()),
          InfoRow(title: "التوقف عن العمل", value: employeeModel.workStops.toString()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
