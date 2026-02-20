import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../mobile/fabric_mobile_layout.dart';

class FabricView extends StatelessWidget {
  const FabricView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => FabricMobileLayout(),
      tabletLayout: (context) => FabricMobileLayout(),
      desktopLayout: (context) => FabricMobileLayout(),
    );
  }
}
