import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/service_locator.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../data/repositories/accessories_repo_impl.dart';
import '../layouts/mobile/accessories_mobile_layout.dart';
import '../manager/accessories_cubit.dart';

class AccessoriesView extends StatelessWidget {
  const AccessoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccessoriesCubit(getIt.get<AccessoriesRepoImpl>())..getAccessories(),
      child: AdaptiveLayout(
        mobilLayout: (context) => AccessoriesMobileLayout(),
        tabletLayout: (context) => AccessoriesMobileLayout(),
        desktopLayout: (context) => AccessoriesMobileLayout(),
      ),
    );
  }
}
