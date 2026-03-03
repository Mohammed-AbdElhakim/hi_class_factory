import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../attendance/data/models/attendance_model.dart';
import '../../../../attendance/data/models/attendance_record_model.dart';
import '../../../../employee/data/models/employee_model.dart';
import '../../manager/payroll/payroll_cubit.dart';
import '../../manager/salaries/salaries_cubit.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الرواتب',
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
              return const Center(child: Text("لا يوجد حضور وانصراف"));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  child: CustomDropdown<AttendanceModel>.search(
                    hintText: 'اختر الفترة',
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
                        return Center(child: Text('اختر فترة لعرض الرواتب'));
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
                                    "لم يتم العثور على كشوف المرتبات من فضلك احسب رواتب الفترة",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      //عايز الموظفين وعايز شيت الاكسيل
                                      // employeeList
                                      // attendanceSelected?.records
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Center(
                                              child: Text("جارى العمل عليها قريباً"),
                                            ),
                                            // content: Text("جاى العمل عليها قريباً"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // اعمل العملية هنا
                                                  Navigator.pop(context);
                                                },
                                                child: Text("تم"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('احسب الرواتب'),
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
                        return ListView.builder(
                          itemCount: payrollDetails.employeesPayroll.length,
                          itemBuilder: (_, index) {
                            final emp = payrollDetails.employeesPayroll[index];
                            return Card(
                              child: ListTile(
                                title: Text(emp.employeeName),
                                subtitle: Text(
                                  'حضور: ${emp.attendanceDays} | غياب: ${emp.absenceDays} | أجر صافي: ${emp.bonus}',
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
        },
      ),
    );
  }
}
