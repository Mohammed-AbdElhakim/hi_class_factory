import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../layouts/mobile/save_excel_mobile_layout.dart';

class SaveExcelView extends StatelessWidget {
  const SaveExcelView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => SaveExcelMobileLayout(),
      tabletLayout: (context) => SaveExcelMobileLayout(),
      desktopLayout: (context) => SaveExcelMobileLayout(),
    );
  }
}
