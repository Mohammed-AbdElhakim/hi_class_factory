import 'package:flutter/material.dart';

class SalaryDetailsMobileLayout extends StatefulWidget {
  const SalaryDetailsMobileLayout({super.key});

  @override
  State<SalaryDetailsMobileLayout> createState() => _SalaryDetailsMobileLayoutState();
}

class _SalaryDetailsMobileLayoutState extends State<SalaryDetailsMobileLayout> {
  // int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'تفاصيل الراتب',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.orange),
            onPressed: () {
              // Print functionality
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Section
                  _buildProfileSection(),
                  const SizedBox(height: 20),

                  // Monthly Salary Details
                  _buildSalaryDetailsSection(),
                  const SizedBox(height: 16),

                  // Deductions Section
                  _buildDeductionsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade200, width: 3),
              color: Colors.orange.shade50,
            ),
            child: Icon(Icons.person, size: 50, color: Colors.orange.shade700),
          ),
          const SizedBox(height: 16),

          // Name
          const Text(
            'أحمد محمد علي',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Position Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'خياط أول',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Employee ID
          Text(
            'الرقم الوظيفي: #EMP-12345',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          // Section Header
          Row(
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              const Text(
                'تفصيل الراتب الشهري',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 32),

          // Salary Items
          _buildSalaryRow('الراتب الأساسي', '5,500.00', 'رس'),
          const SizedBox(height: 12),
          _buildSalaryRow('بدل سكن', '1,200.00', 'رس'),
          const SizedBox(height: 12),
          _buildSalaryRow('بدل نقل', '500.00', 'رس'),
          const Divider(height: 32),

          // Total
          _buildSalaryRow('إجمالي الاستحقاقات', '7,200.00', 'رس', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDeductionsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          // Section Header
          Row(
            children: [
              Icon(Icons.remove_circle_outline, color: Colors.red.shade700),
              const SizedBox(width: 8),
              const Text(
                'الاستقطاعات والسلف',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 32),

          // Deduction Items
          _buildDeductionRow('أقساط سلفة', '500.00', 'رس'),
          const SizedBox(height: 12),
          _buildDeductionRow('غياب (يوم واحد)', '183.33', 'رس'),
          const SizedBox(height: 12),
          _buildDeductionRow('تأمينات اجتماعية', '495.00', 'رس'),
          const Divider(height: 32),

          // Total Deductions
          _buildSalaryRow(
            'إجمالي الاستقطاعات',
            '1,178.33',
            'رس',
            isTotal: true,
            totalColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryRow(
    String label,
    String amount,
    String currency, {
    bool isTotal = false,
    Color? totalColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? (totalColor ?? Colors.orange.shade700)
                : Colors.grey.shade700,
          ),
        ),
        Text(
          '$amount $currency',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? (totalColor ?? Colors.orange.shade700) : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDeductionRow(String label, String amount, String currency) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        Text(
          '- $amount $currency',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade600,
          ),
        ),
      ],
    );
  }
}
