import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../manager/save_excel/save_excel_cubit.dart';
import '../../manager/save_excel/save_excel_state.dart';
import '../../widgets/attendance_data_source.dart';

class SaveExcelMobileLayout extends StatelessWidget {
  const SaveExcelMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SaveExcelCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        appBar: AppBar(title: const Text("رفع ملف الحضور")),
        body: BlocConsumer<SaveExcelCubit, SaveExcelState>(
          listener: (context, state) {
            if (state.status == SaveStatus.success) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("تم الرفع بنجاح")));

              Navigator.pop(context); // 👈 يرجع للشاشة اللي قبلها
            }

            if (state.status == SaveStatus.failure && state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error ?? "حدث خطأ")));
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  /// 1️⃣ اختيار الفترة
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );

                            if (picked != null) {
                              context.read<SaveExcelCubit>().setDateRange(picked);
                            }
                          },
                          child: const Text("اختيار الفترة"),
                        ),

                        const SizedBox(width: 10),

                        /// عرض الفترة
                        Text(
                          state.selectedRange == null
                              ? "لم يتم اختيار فترة"
                              : "${state.selectedRange!.start.toString().split(' ').first}"
                                    "  →  "
                                    "${state.selectedRange!.end.toString().split(' ').first}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 20),
                  if (state.data.isEmpty)
                    /// اختيار ملف Excel
                    ElevatedButton(
                      onPressed: () => context.read<SaveExcelCubit>().pickAndReadExcel(),
                      child: const Text("اختار ملف Excel"),
                    ),

                  const SizedBox(height: 10),

                  if (state.status == SaveStatus.loading && state.data.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),

                  const SizedBox(height: 10),

                  /// عرض البيانات
                  if (state.data.isNotEmpty)
                    Expanded(
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          gridLineColor: Colors.grey.shade300,
                          headerColor: Color(0xff904A42),
                        ),
                        child: SfDataGrid(
                          source: AttendanceDataSource(records: state.data),
                          allowSorting: false,
                          headerRowHeight: 35,
                          rowHeight: 35,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          columnWidthMode: ColumnWidthMode.auto,
                          isScrollbarAlwaysShown: true,

                          horizontalScrollPhysics: const BouncingScrollPhysics(),
                          columns: [
                            GridColumn(
                              columnName: 'AC-No',
                              label: Center(
                                child: Text(
                                  'AC-No',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Name',
                              label: Center(
                                child: Text(
                                  'Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Date',
                              label: Center(
                                child: Text(
                                  'Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Timetable',
                              label: Center(
                                child: Text(
                                  'Timetable',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'OnDuty',
                              label: Center(
                                child: Text(
                                  'On Duty',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'OffDuty',
                              label: Center(
                                child: Text(
                                  'Off Duty',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'ClockIn',
                              label: Center(
                                child: Text(
                                  'Clock In',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'ClockOut',
                              label: Center(
                                child: Text(
                                  'Clock Out',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Normal',
                              label: Center(
                                child: Text(
                                  'Normal',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'RealTime',
                              label: Center(
                                child: Text(
                                  'Real Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Late',
                              label: Center(
                                child: Text(
                                  'Late',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Early',
                              label: Center(
                                child: Text(
                                  'Early',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Absent',
                              label: Center(
                                child: Text(
                                  'Absent',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'OTTime',
                              label: Center(
                                child: Text(
                                  'OT Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'WorkTime',
                              label: Center(
                                child: Text(
                                  'Work Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'NDays',
                              label: Center(
                                child: Text(
                                  'NDays',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'ATTTime',
                              label: Center(
                                child: Text(
                                  'ATT Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'NDaysOT',
                              label: Center(
                                child: Text(
                                  'NDays OT',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  /// زرار الرفع
                  if (state.data.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 8),
                      child: ElevatedButton(
                        onPressed: state.status == SaveStatus.loading
                            ? null
                            : () {
                                context.read<SaveExcelCubit>().uploadToFirebase();
                              },
                        child: state.status == SaveStatus.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text("رفع البيانات"),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
