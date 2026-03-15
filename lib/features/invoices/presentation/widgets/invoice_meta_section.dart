import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';
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
            MetaCard(label: S.of(context).invoiceNumber, value: invoice.invoiceNumber),
            const SizedBox(height: 10),
            MetaCard(
              label: S.of(context).date,
              value: DateFormat('yyyy/MM/dd  -  hh:mm a', 'en').format(invoice.date),
            ),
          ],
        ),
      ),
    );
  }
}
