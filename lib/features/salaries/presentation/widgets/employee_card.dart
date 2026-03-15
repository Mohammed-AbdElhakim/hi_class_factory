import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/salaries/presentation/layouts/mobile/salary_details_mobile_layout.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/employee_payroll_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.emp});
  final EmployeePayrollModel emp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalaryDetailsMobileLayout(employeeData: emp),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(emp.employeeName),
          subtitle: Text(emp.employeeData.jobTitle),
          leading: CircleAvatar(radius: 25, child: Text(emp.employeeName[0])),
          trailing: Text(
            '${emp.salaryResult.finalSalary} ${S.of(context).egp}',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
