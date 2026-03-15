import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';
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
              label: S.of(context).totalItems,
              value: invoice.totalBeforeDiscount.toString(),
            ),
            const SizedBox(height: 8),
            // الضريبة
            TotalRow(
              label:
                  '${S.of(context).discount} (${((invoice.discount / invoice.totalAfterDiscount) * 100).toStringAsFixed(2)}%)',
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
                  S.of(context).grandTotal,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${invoice.totalAfterDiscount} ${S.of(context).egp}',
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
              '${S.of(context).only} ${getIntegerByArabic(context, invoice.totalAfterDiscount)} ${S.of(context).noMore}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String getIntegerByArabic(BuildContext context, double total) {
    int integerPart = total.floor();
    int decimalPart = ((total - integerPart) * 100).round();
    if (decimalPart == 0) {
      return "${Tafqeet.convert("$integerPart")} ${S.of(context).pound} ";
    } else if (decimalPart > 0) {
      return "${Tafqeet.convert("$integerPart")} ${S.of(context).pound} ${S.of(context).and} "
          "${Tafqeet.convert("$decimalPart")} ${S.of(context).piastre} ";
    }
    return '';
  }
}
