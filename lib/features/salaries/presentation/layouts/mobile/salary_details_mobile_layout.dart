import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../../data/models/employee_payroll_model.dart';
import '../../widgets/build_profile_section.dart';
import '../../widgets/build_salary_details_section.dart';

class SalaryDetailsMobileLayout extends StatelessWidget {
  const SalaryDetailsMobileLayout({super.key, required this.employeeData});
  final EmployeePayrollModel employeeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).salariesDetails,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            BuildProfileSection(
              name: employeeData.employeeData.name,
              job: employeeData.employeeData.jobTitle,
            ),
            const SizedBox(height: 20),

            // Monthly Salary Details
            BuildSalaryDetailsSection(employeeData: employeeData),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
