import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../../../../core/constants/service_locator.dart';
import '../../data/repositories/attendance_repo_impl.dart';
import '../layouts/mobile/attendance_mobile_layout.dart';
import '../manager/attendance/attendance_cubit.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AttendanceCubit(getIt.get<AttendanceRepoImpl>())..loadPeriods(),
      child: AdaptiveLayout(
        mobilLayout: (context) => AttendanceMobileLayout(),
        tabletLayout: (context) => AttendanceMobileLayout(),
        desktopLayout: (context) => AttendanceMobileLayout(),
      ),
    );
  }
}
