import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../invoices/data/models/invoice_model.dart';
import 'invoice_details_sheet.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openInvoiceDetailsSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    invoice.status == InvoiceStatus.paid ? "مدفوع" : invoice.status.name,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  invoice.invoiceNumber,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "تاريخ: ${DateFormat('yyyy/MM/dd  -  hh:mm a', 'en').format(invoice.date)}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

            Text(
              invoice.customerName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const Divider(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("القيمة الإجمالية", style: TextStyle(color: Colors.grey)),
                Text(
                  "${invoice.totalAfterDiscount} ج.م",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openInvoiceDetailsSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: .7,
        child: InvoiceDetailsSheet(invoice: invoice),
      ),
    );
  }
}
