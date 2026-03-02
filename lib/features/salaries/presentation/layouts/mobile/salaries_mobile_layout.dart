/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/firebase/firebase_service.dart';
import '../../../data/models/payroll_model.dart';
import '../../manager/salaries_cubit.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payrolls')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final cubit = context.read<PayrollCubit>();
              cubit.generateWeeklyPayroll(
                fromDate: DateTime(2026, 2, 1),
                toDate: DateTime(2026, 2, 7),
              );
            },
            child: const Text('Generate Payroll for Week 1'),
          ),
          BlocBuilder<PayrollCubit, PayrollState>(
            builder: (context, state) {
              if (state is PayrollLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PayrollFailure) {
                return Center(child: Text('Error: ${state.massage}'));
              } else {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseService.collectionMain)
                      .doc(FirebaseService.factoryId)
                      .collection('payroll')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final payrolls = snapshot.data!.docs
                        .map(
                          (doc) => PayrollModel(
                            employeeId: doc['employeeId'],
                            fromDate: (doc['fromDate'] as Timestamp).toDate(),
                            toDate: (doc['toDate'] as Timestamp).toDate(),
                            weeklyBase: doc['weeklyBase'],
                            absenceDeduction: doc['absenceDeduction'],
                            lateDeduction: doc['lateDeduction'],
                            overtimeAmount: doc['overtimeAmount'],
                            productionBonus: doc['productionBonus'],
                            netSalary: doc['netSalary'],
                            isApproved: doc['isApproved'],
                            isPaid: doc['isPaid'],
                            createdAt: (doc['createdAt'] as Timestamp).toDate(),
                          ),
                        )
                        .toList();

                    if (payrolls.isEmpty) {
                      return const Center(child: Text('No payroll records'));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: payrolls.length,
                        itemBuilder: (context, index) {
                          final payroll = payrolls[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              title: Text('Employee ID: ${payroll.employeeId}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Period: ${payroll.fromDate.toLocal().toShortDateString()} - ${payroll.toDate.toLocal().toShortDateString()}',
                                  ),
                                  Text(
                                    'Weekly Base: \$${payroll.weeklyBase.toStringAsFixed(2)}',
                                  ),
                                  Text(
                                    'Absence Deduction: \$${payroll.absenceDeduction.toStringAsFixed(2)}',
                                  ),
                                  Text(
                                    'Late Deduction: \$${payroll.lateDeduction.toStringAsFixed(2)}',
                                  ),
                                  Text(
                                    'Overtime: \$${payroll.overtimeAmount.toStringAsFixed(2)}',
                                  ),
                                  Text(
                                    'Net Salary: \$${payroll.netSalary.toStringAsFixed(2)}',
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    payroll.isApproved
                                        ? Icons.check_circle
                                        : Icons.pending,
                                    color: payroll.isApproved
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                  Icon(
                                    payroll.isPaid ? Icons.attach_money : Icons.money_off,
                                    color: payroll.isPaid ? Colors.green : Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

extension DateTimeFormatter on DateTime {
  String toShortDateString() {
    return '${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year}';
  }
}*/

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../attendance/data/models/attendance_model.dart';
import '../../../../attendance/data/models/attendance_record_model.dart';
import '../../manager/salaries_cubit.dart';

class SalariesMobileLayout extends StatefulWidget {
  const SalariesMobileLayout({super.key});

  @override
  State<SalariesMobileLayout> createState() => _SalariesMobileLayoutState();
}

class _SalariesMobileLayoutState extends State<SalariesMobileLayout> {
  AttendanceModel? attendanceSelected;
  List<AttendanceRecordModel>? recordsList;

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
            final List<AttendanceModel> attendanceList = state.attendanceList;
            // attendanceSelected = attendanceList.last;
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
                      });
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
