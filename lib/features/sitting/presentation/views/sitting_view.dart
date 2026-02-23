import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/sitting_mobile_layout.dart';

class SittingView extends StatelessWidget {
  const SittingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => SittingMobileLayout(),
      tabletLayout: (context) => SittingMobileLayout(),
      desktopLayout: (context) => SittingMobileLayout(),
    );
  }
}
