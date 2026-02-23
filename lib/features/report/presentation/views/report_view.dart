import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/report_mobile_layout.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => ReportMobileLayout(),
      tabletLayout: (context) => ReportMobileLayout(),
      desktopLayout: (context) => ReportMobileLayout(),
    );
  }
}
