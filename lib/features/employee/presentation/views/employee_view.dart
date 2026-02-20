import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';
import 'package:hi_class_factory/features/employee/presentation/layouts/employee_mobile_layout.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => EmployeeMobileLayout(),
      tabletLayout: (context) => EmployeeMobileLayout(),
      desktopLayout: (context) => EmployeeMobileLayout(),
    );
  }
}
