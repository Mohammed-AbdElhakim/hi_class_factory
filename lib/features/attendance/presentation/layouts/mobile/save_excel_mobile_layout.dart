import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/save_excel/save_excel_cubit.dart';
import '../../manager/save_excel/save_excel_state.dart';
import '../../widgets/custom_table_data.dart';

class SaveExcelMobileLayout extends StatefulWidget {
  const SaveExcelMobileLayout({super.key});

  @override
  State<SaveExcelMobileLayout> createState() => _SaveExcelMobileLayoutState();
}

class _SaveExcelMobileLayoutState extends State<SaveExcelMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SaveExcelCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        appBar: AppBar(title: Text(S.of(context).uploadAttendanceFile)),
        body: BlocConsumer<SaveExcelCubit, SaveExcelState>(
          listener: (context, state) {
            if (state.status == SaveStatus.success) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(S.of(context).uploadSuccess)));

              Navigator.pop(context, true); // 👈 يرجع للشاشة اللي قبلها
            }

            if (state.status == SaveStatus.failure && state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? S.of(context).errorOccurred)),
              );
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
                            final cubit = context.read<SaveExcelCubit>();

                            final picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );

                            if (picked != null) {
                              cubit.setDateRange(picked);
                            }
                          },
                          child: Text(S.of(context).selectPeriod),
                        ),

                        const SizedBox(width: 10),

                        /// عرض الفترة
                        Text(
                          state.selectedRange == null
                              ? S.of(context).noPeriodSelected
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
                      child: Text(S.of(context).chooseExcelFile),
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
                    Expanded(child: CustomTableData(records: state.data)),

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
                            : Text(S.of(context).uploadData),
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
