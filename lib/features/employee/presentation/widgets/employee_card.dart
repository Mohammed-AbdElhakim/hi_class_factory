import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee, this.onDelete, this.onEdit});

  final EmployeeModel employee;
  final VoidCallback? onDelete;
  final ValueChanged<EmployeeModel>? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xff904A42),
              child: Text(
                employee.name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(employee.jobTitle, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            PopupMenuButton<String>(
              iconColor: Colors.black,
              onSelected: (value) async {
                if (value == "edit" && onEdit != null) {
                  onEdit!(employee);
                } else if (value == "delete" && onDelete != null) {
                  onDelete!();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: "edit", child: Text(S.of(context).edit)),
                PopupMenuItem(value: "delete", child: Text(S.of(context).delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
