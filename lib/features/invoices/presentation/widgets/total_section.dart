import 'package:flutter/material.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';

import '../../data/models/invoice_model.dart';
import 'total_row.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key, required this.invoice});
  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // إجمالي الأصناف
            TotalRow(
              label: 'إجمالي الأصناف',
              value: invoice.totalBeforeDiscount.toString(),
            ),
            const SizedBox(height: 8),
            // الضريبة
            TotalRow(
              label:
                  'الخصم (${((invoice.discount / invoice.totalAfterDiscount) * 100).toStringAsFixed(2)}%)',
              value: invoice.discount.toString(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: Color(0xFF5A2A00)),
            ),
            // الإجمالي الكلي
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي الكلي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${invoice.totalAfterDiscount} ج.م',
                  style: TextStyle(
                    color: Color(0xFFCC0000),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // المبلغ كتابةً
            Text(
              'فقط ${getIntegerByArabic(invoice.totalAfterDiscount)} لا غير',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String getIntegerByArabic(double total) {
    int integerPart = total.floor();
    int decimalPart = ((total - integerPart) * 100).round();
    if (decimalPart == 0) {
      return "${Tafqeet.convert("$integerPart")} جنيهاً مصريا ";
    } else if (decimalPart > 0) {
      return "${Tafqeet.convert("$integerPart")} جنيهاً مصريا و "
          "${Tafqeet.convert("$decimalPart")} قرشاً ";
    }
    return '';
  }
}
