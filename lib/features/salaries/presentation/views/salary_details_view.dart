import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/salary_details_mobile_layout.dart';

class SalaryDetailsView extends StatelessWidget {
  const SalaryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => SalaryDetailsMobileLayout(),
      tabletLayout: (context) => SalaryDetailsMobileLayout(),
      desktopLayout: (context) => SalaryDetailsMobileLayout(),
    );
  }
}
