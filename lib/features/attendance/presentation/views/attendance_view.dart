import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/attendance_mobile_layout.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => AttendanceMobileLayout(),
      tabletLayout: (context) => AttendanceMobileLayout(),
      desktopLayout: (context) => AttendanceMobileLayout(),
    );
  }
}
