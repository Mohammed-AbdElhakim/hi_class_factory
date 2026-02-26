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
