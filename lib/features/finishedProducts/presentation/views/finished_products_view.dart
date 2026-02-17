import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/service_locator.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/finished_products_repo_impl.dart';
import '../layouts/mobile/finished_products_mobile_layout.dart';
import '../manager/finished_products_cubit.dart';

class FinishedProductsView extends StatefulWidget {
  const FinishedProductsView({super.key});

  @override
  State<FinishedProductsView> createState() => _FinishedProductsViewState();
}

class _FinishedProductsViewState extends State<FinishedProductsView> {
  final List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FinishedProductsCubit(getIt.get<FinishedProductsRepoImpl>())
            ..getFinishedProducts(),
      child: AdaptiveLayout(
        mobilLayout: (context) => FinishedProductsMobileLayout(),
        tabletLayout: (context) => FinishedProductsMobileLayout(),
        desktopLayout: (context) => FinishedProductsMobileLayout(),
      ),
    );
  }
}
