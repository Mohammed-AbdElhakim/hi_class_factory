import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';
import 'package:hi_class_factory/features/salaries/presentation/manager/salaries_cubit.dart';

import '../../../../core/constants/service_locator.dart';
import '../../data/repositories/salaries_repo_impl.dart';
import '../layouts/mobile/salaries_mobile_layout.dart';

class SalariesView extends StatelessWidget {
  const SalariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalariesCubit(getIt.get<SalariesRepoImpl>())..getAttendance(),
      child: AdaptiveLayout(
        mobilLayout: (context) => SalariesMobileLayout(),
        // tabletLayout: (context) => PayrollScreen(),
        // desktopLayout: (context) => PayrollScreen(),
        tabletLayout: (context) => SalariesMobileLayout(),
        desktopLayout: (context) => SalariesMobileLayout(),
      ),
    );
  }
}
