import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/invoice_model.dart';
import 'meta_card.dart';

class InvoiceMetaSection extends StatelessWidget {
  const InvoiceMetaSection({super.key, required this.invoice});
  final InvoiceModel invoice;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MetaCard(label: 'رقم الفاتورة', value: invoice.invoiceNumber),
            const SizedBox(height: 10),
            MetaCard(
              label: 'التاريخ',
              value: DateFormat('yyyy/MM/dd  -  hh:mm a', 'en').format(invoice.date),
            ),
          ],
        ),
      ),
    );
  }
}
