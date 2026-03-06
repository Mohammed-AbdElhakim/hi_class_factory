import 'package:flutter/material.dart';

class InvoiceTitleSection extends StatelessWidget {
  const InvoiceTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // العنوان والوصف
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'فاتورة مبيعات',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text('تفاصيل المعاملة المالية', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
