import 'package:flutter/material.dart';

import '../../../../core/responsive/adaptive_layout.dart';
import '../../data/models/product_model.dart';
import '../layouts/mobile/finished_products_mobile_layout.dart';

class FinishedProductsView extends StatefulWidget {
  const FinishedProductsView({super.key});

  @override
  State<FinishedProductsView> createState() => _FinishedProductsViewState();
}

class _FinishedProductsViewState extends State<FinishedProductsView> {
  final List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobilLayout: (context) => FinishedProductsMobileLayout(),
      tabletLayout: (context) => FinishedProductsMobileLayout(),
      desktopLayout: (context) => FinishedProductsMobileLayout(),
    );
  }
}
