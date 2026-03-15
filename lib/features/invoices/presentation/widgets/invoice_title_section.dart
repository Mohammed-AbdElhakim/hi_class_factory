import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

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
              children: [
                Text(
                  S.of(context).salesInvoice,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(S.of(context).invoiceDescription, style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
