import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/attendance_repo_impl.dart';
import '../manager/attendance/attendance_cubit.dart';
import 'custom_table_data.dart';

class AttendanceRecordsBottomSheet extends StatefulWidget {
  final String periodId;

  const AttendanceRecordsBottomSheet({super.key, required this.periodId});

  @override
  State<AttendanceRecordsBottomSheet> createState() =>
      _AttendanceRecordsBottomSheetState();
}

class _AttendanceRecordsBottomSheetState extends State<AttendanceRecordsBottomSheet> {
  @override
  void initState() {
    super.initState();

    // context.read<AttendanceCubit>().loadRecords(periodId: widget.periodId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AttendanceCubit(getIt.get<AttendanceRepoImpl>())
            ..loadRecords(periodId: widget.periodId),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        appBar: AppBar(title: Text(S.of(context).attendanceDetails)),

        body: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AttendanceRecordsLoaded) {
              return CustomTableData(records: state.records);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
