import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';
import 'package:hi_class_factory/features/finalProductStore/presentation/layouts/desktop/final_product_store_desktop_layout.dart';

import '../layouts/mobile/final_product_store_mobile_layout.dart';

class FinalProductStoreView extends StatelessWidget {
  const FinalProductStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) =>
          FinalProductStoreMobileLayout(pageName: "مخزن المنتج النهائي"),
      tabletLayout: (context) =>
          FinalProductStoreDesktopLayout(pageName: "مخزن المنتج النهائي"),
      desktopLayout: (context) =>
          FinalProductStoreDesktopLayout(pageName: "مخزن المنتج النهائي"),
    );
  }
}
