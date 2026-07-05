import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expense;

  const HomeHeader({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${totalBalance.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummary(
                  context,
                  label: 'Income',
                  amount: income,
                  icon: Icons.arrow_downward_rounded,
                  iconColor: Colors.greenAccent,
                ),
                _buildSummary(
                  context,
                  label: 'Expenses',
                  amount: expense,
                  icon: Icons.arrow_upward_rounded,
                  iconColor: Colors.redAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context, {
    required String label,
    required double amount,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white24,
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              '\$${amount.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
