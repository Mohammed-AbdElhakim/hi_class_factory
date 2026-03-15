import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/settings_mobile_layout.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => SettingsMobileLayout(),
      tabletLayout: (context) => SettingsMobileLayout(),
      desktopLayout: (context) => SettingsMobileLayout(),
    );
  }
}
