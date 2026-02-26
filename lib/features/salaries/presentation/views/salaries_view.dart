import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/salaries_mobile_layout.dart';

class SalariesView extends StatelessWidget {
  const SalariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => SalariesMobileLayout(),
      tabletLayout: (context) => SalariesMobileLayout(),
      desktopLayout: (context) => SalariesMobileLayout(),
    );
  }
}
