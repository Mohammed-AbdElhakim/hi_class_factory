/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/firebase/firebase_service.dart';
import '../../../data/models/payroll_model.dart';
import '../../manager/payroll__cubit.dart';

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

import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';

import '../../../data/models/employee_model.dart';
import '../../widgets/build_month_tab.dart';
import '../../widgets/employee_card.dart';

class SalariesMobileLayout extends StatefulWidget {
  const SalariesMobileLayout({super.key});

  @override
  State<SalariesMobileLayout> createState() => _SalariesMobileLayoutState();
}

class _SalariesMobileLayoutState extends State<SalariesMobileLayout> {
  final List<EmployeeModel> employees = [
    EmployeeModel(
      id: 'EMP-001',
      name: 'أحمد محمد علي',
      position: 'خياط رئيسي',
      salary: 5400.0,
      photo: AppAssets.avatar,
    ),
    EmployeeModel(
      id: 'EMP-002',
      name: 'محمود حسن',
      position: 'مدير المستودع',
      salary: 8200.0,
      photo: AppAssets.avatar,
    ),
  ];
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
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'البحث عن موظف...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey.shade400),
              ),
            ),
          ),

          // Month Filter
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                BuildMonthTab(month: 'يوليو'),
                const SizedBox(width: 8),
                BuildMonthTab(month: 'أغسطس'),
                const SizedBox(width: 8),
                BuildMonthTab(month: 'سبتمبر'),
                const SizedBox(width: 8),
                BuildMonthTab(month: 'أكتوبر', isSelected: true),
                const SizedBox(width: 8),
                BuildMonthTab(month: 'نوفيمبر'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Employee List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: employees.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return EmployeeCard(employee: employees[index]);
              },
            ),
          ),

          // Total Salary Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'إجمالي الرواتب المصروفة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '29,450 ج.م',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
