import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'icon_button_dark.dart';

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
            // أزرار الطباعة والمشاركة
            Row(
              children: [
                IconButtonDark(
                  icon: Icons.share_outlined,
                  onTap: () {
                    context.pop(true);
                  },
                ),
                const SizedBox(width: 8),
                IconButtonDark(
                  icon: Icons.print_outlined,
                  onTap: () {
                    context.pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
