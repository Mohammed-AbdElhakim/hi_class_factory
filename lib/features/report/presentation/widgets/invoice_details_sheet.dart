import 'package:flutter/material.dart';

import '../../../invoices/data/models/invoice_model.dart';
import 'item_row.dart';

class InvoiceDetailsSheet extends StatelessWidget {
  const InvoiceDetailsSheet({super.key, required this.invoice});
  final InvoiceModel invoice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "تفاصيل الفاتورة",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        // رأس الجدول والاساسى من هنا
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(color: Colors.brown),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'الصنف',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    // color: Color(0xFFCC0000),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'العدد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Color(0xFFCC0000),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'سعر الوحدة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Color(0xFFCC0000),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'الإجمالي',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    // color: Color(0xFFCC0000),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        // صفوف الأصناف
        ...invoice.items.asMap().entries.map((entry) {
          var item = entry.value; // ده العنصر
          return ItemRow(item: item);
        }),
      ],
    );
  }
}
