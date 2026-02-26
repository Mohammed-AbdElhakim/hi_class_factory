import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/salaries/presentation/views/salary_details_view.dart';

import '../../data/models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SalaryDetailsView()),
          );
        },
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(employee.photo),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: SizedBox(),
                // Icon(Icons.person, color: Colors.grey.shade400, size: 30),
              ),
            ),
            const SizedBox(width: 12),
            // Employee Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.position,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${employee.salary} ج.م',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(width: 8),
            // Menu Button
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'view',
                  child: Text('عرض التفاصيل'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalaryDetailsView()),
                    );
                  },
                ),
                const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                const PopupMenuItem(value: 'delete', child: Text('حذف')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Color _getStatusColor(String status) {
  //   switch (status) {
  //     case 'paid':
  //       return const Color(0xFFD4F4DD);
  //     case 'pending':
  //       return const Color(0xFFFFF3CD);
  //     case 'processing':
  //       return const Color(0xFFD6E5FF);
  //     default:
  //       return Colors.grey.shade200;
  //   }
  // }
  //
  // Color _getStatusTextColor(String status) {
  //   switch (status) {
  //     case 'paid':
  //       return const Color(0xFF28A745);
  //     case 'pending':
  //       return const Color(0xFF856404);
  //     case 'processing':
  //       return const Color(0xFF007BFF);
  //     default:
  //       return Colors.grey;
  //   }
  // }
}
