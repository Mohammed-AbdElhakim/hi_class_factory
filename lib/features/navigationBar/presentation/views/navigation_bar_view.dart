import 'package:flutter/material.dart';

import '../../../../core/responsive/adaptive_layout.dart';
import '../layouts/mobile/navigation_bar_mobile_layout.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => NavigationBarMobileLayout(),
      desktopLayout: (context) => NavigationBarMobileLayout(),
      tabletLayout: (context) => NavigationBarMobileLayout(),
    );
  }
}
