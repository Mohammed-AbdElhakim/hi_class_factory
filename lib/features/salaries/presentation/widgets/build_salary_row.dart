import 'package:flutter/material.dart';

class BuildSalaryRow extends StatelessWidget {
  const BuildSalaryRow({
    super.key,
    required this.label,
    required this.amount,
    required this.currency,
    this.isTotal = false,
    this.totalColor,
  });

  final String label;
  final String amount;
  final String currency;
  final bool isTotal;
  final Color? totalColor;

  @override
  Widget build(BuildContext context) {
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
}
