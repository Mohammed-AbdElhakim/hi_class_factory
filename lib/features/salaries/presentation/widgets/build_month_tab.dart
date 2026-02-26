import 'package:flutter/material.dart';

class BuildMonthTab extends StatelessWidget {
  const BuildMonthTab({super.key, required this.month, this.isSelected = false});
  final String month;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          month,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
