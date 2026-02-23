import 'package:flutter/material.dart';

import '../../data/models/invoice_model.dart';

class ClientSection extends StatelessWidget {
  const ClientSection({super.key, required this.invoice});
  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اسم العميل',
                  style: TextStyle(color: Color(0xFFCC0000), fontSize: 18),
                ),
                SizedBox(height: 6),
                Text(
                  invoice.customerName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
