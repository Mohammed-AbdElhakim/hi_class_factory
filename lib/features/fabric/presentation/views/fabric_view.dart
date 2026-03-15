import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/service_locator.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../../data/repositories/fabric_stock/fabric_stock_repo_impl.dart';
import '../layouts/mobile/fabric_mobile_layout.dart';
import '../manager/fabric_stock/fabric_stock_cubit.dart';

class FabricView extends StatelessWidget {
  const FabricView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FabricStockCubit(getIt.get<FabricStockRepoImpl>())..getFabricStock(),
      child: AdaptiveLayout(
        mobilLayout: (context) => FabricMobileLayout(),
        tabletLayout: (context) => FabricMobileLayout(),
        desktopLayout: (context) => FabricMobileLayout(),
      ),
    );
  }
}
