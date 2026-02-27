import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../manager/attendance/attendance_cubit.dart';
import '../../views/save_excel_view.dart';
import '../../widgets/attendance_records_bottom_sheet.dart';

class AttendanceMobileLayout extends StatefulWidget {
  const AttendanceMobileLayout({super.key});

  @override
  State<AttendanceMobileLayout> createState() => _AttendanceMobileLayoutState();
}

class _AttendanceMobileLayoutState extends State<AttendanceMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text("الحضور والانصراف"),
        actions: [
          IconButton(
            onPressed: () async {
              final cubit = context.read<AttendanceCubit>();
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => SaveExcelView()),
              );
              if (result == true) {
                cubit.loadPeriods();
              }
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 20),
        ],
      ),

      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<AttendanceCubit>();
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceError) {
            return Center(child: Text(state.message));
          } else if (state is AttendancePeriodsLoaded) {
            final attendanceList = state.periods;
            if (attendanceList.isEmpty) {
              return const Center(child: Text("لا يوجد بيانات"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                final period = attendanceList[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      " من ${DateFormat('yyyy/MM/dd', 'en').format(period.fromDate!)}\n إلي ${DateFormat('yyyy/MM/dd', 'en').format(period.toDate!)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("عدد السجلات: ${period.recordsCount}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("تأكيد الحذف"),
                            content: const Text("هل أنت متأكد من حذف الفترة؟"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("إلغاء"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("حذف"),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          cubit.deletePeriod(periodId: period.id!);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AttendanceRecordsBottomSheet(periodId: period.id!),
                        ),
                      );
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   builder: (_) =>
                      //       ,
                      // );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
        },
      ),
    );
  }
}
