import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../../attendance/data/models/attendance_model.dart';
import '../../../../attendance/data/models/attendance_record_model.dart';
import '../../../../employee/data/models/employee_model.dart';
import '../../manager/payroll/payroll_cubit.dart';
import '../../manager/salaries/salaries_cubit.dart';
import '../../widgets/employee_card.dart';

class SalariesMobileLayout extends StatefulWidget {
  const SalariesMobileLayout({super.key});

  @override
  State<SalariesMobileLayout> createState() => _SalariesMobileLayoutState();
}

class _SalariesMobileLayoutState extends State<SalariesMobileLayout> {
  AttendanceModel? attendanceSelected;
  List<AttendanceRecordModel>? recordsList;
  String? payrollID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).salaries,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<SalariesCubit, SalariesState>(
        builder: (context, state) {
          if (state is SalariesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SalariesError) {
            return Center(child: Text(state.message));
          } else if (state is SalariesSuccess) {
            final List<AttendanceModel> attendanceList =
                state.attendanceAndEmployeesLists.attendanceList;
            final List<EmployeeModel> employeeList =
                state.attendanceAndEmployeesLists.employeesList;
            if (attendanceList.isEmpty) {
              return Center(child: Text(S.of(context).no_attendance));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  child: CustomDropdown<AttendanceModel>.search(
                    hintText: S.of(context).choose_period,
                    initialItem: attendanceSelected,
                    items: attendanceList,
                    excludeSelected: false,
                    onChanged: (attendance) {
                      setState(() {
                        attendanceSelected = attendance;
                        recordsList = attendance?.records;
                        payrollID =
                            "from(${DateFormat('yyyy-MM-dd', 'en').format(attendance!.fromDate!)})"
                            "to(${DateFormat('yyyy-MM-dd', 'en').format(attendance.toDate!)})";
                        context.read<PayrollCubit>().loadPayroll(payrollID!);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<PayrollCubit, PayrollState>(
                    builder: (context, state) {
                      if (state is PayrollInitial) {
                        return Center(child: Text(S.of(context).selectPeriodToView));
                      } else if (state is PayrollLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PayrollError) {
                        // لو الخطأ "Payroll not found" نعرض زرار حساب الرواتب
                        if (state.message.contains('لم يتم العثور على كشوف المرتبات')) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  Text(
                                    S.of(context).noPayrollFound,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      //عايز الموظفين وعايز شيت الاكسيل
                                      context.read<PayrollCubit>().calculatePayroll(
                                        employeeList: employeeList,
                                        attendanceList: attendanceSelected!.records,
                                        payrollId: payrollID!,
                                        fromDate: attendanceSelected!.fromDate!,
                                        toDate: attendanceSelected!.toDate!,
                                      );
                                    },
                                    child: Text(S.of(context).calculateSalaries),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Center(child: Text(state.message));
                      } else if (state is PayrollSaving) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PayrollLoaded) {
                        final payrollDetails = state.payrollDetails;
                        return Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ListView.builder(
                                  itemCount: payrollDetails.employeesPayroll.length,
                                  itemBuilder: (_, index) {
                                    final emp = payrollDetails.employeesPayroll[index];
                                    return EmployeeCard(emp: emp);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).totalPaidSalaries,
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${payrollDetails.payroll.totalNet}  ${S.of(context).egp}",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text(S.of(context).loading));
          }
        },
      ),
    );
  }
}
