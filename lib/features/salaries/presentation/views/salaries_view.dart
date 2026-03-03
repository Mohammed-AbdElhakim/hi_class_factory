import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../../../../core/constants/service_locator.dart';
import '../../data/repositories/salaries_repo_impl.dart';
import '../layouts/mobile/salaries_mobile_layout.dart';
import '../manager/payroll/payroll_cubit.dart';
import '../manager/salaries/salaries_cubit.dart';

class SalariesView extends StatelessWidget {
  const SalariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SalariesCubit(getIt.get<SalariesRepoImpl>())..getAttendanceAndEmployees(),
        ),
        BlocProvider(create: (context) => PayrollCubit(getIt.get<SalariesRepoImpl>())),
      ],
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
