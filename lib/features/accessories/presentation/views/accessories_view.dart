import 'package:flutter/material.dart';

import '../../../../core/responsive/adaptive_layout.dart';
import '../layouts/mobile/accessories_mobile_layout.dart';

class AccessoriesView extends StatelessWidget {
  const AccessoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => AccessoriesMobileLayout(),
      tabletLayout: (context) => AccessoriesMobileLayout(),
      desktopLayout: (context) => AccessoriesMobileLayout(),
    );
  }
}
