import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';
import 'package:hi_class_factory/features/employee/presentation/layouts/employee_mobile_layout.dart';

import '../../../../core/constants/service_locator.dart';
import '../../data/repositories/employee_repo_impl.dart';
import '../manager/employee_cubit.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeCubit(getIt.get<EmployeeRepoImpl>())..getEmployee(),
      child: AdaptiveLayout(
        mobilLayout: (context) => EmployeeMobileLayout(),
        tabletLayout: (context) => EmployeeMobileLayout(),
        desktopLayout: (context) => EmployeeMobileLayout(),
      ),
    );
  }
}
