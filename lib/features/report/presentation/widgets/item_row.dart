import 'package:flutter/material.dart';

import '../../../invoices/data/models/select_product_model.dart';

class ItemRow extends StatelessWidget {
  final SelectProductModel item;

  const ItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.brown, width: 1)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // اسم الصنف
          Expanded(
            flex: 3,
            child: Text(
              "${item.productName} - \n${item.size} - \n${item.colorName}",
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black, fontSize: 13, height: 1.5),
            ),
          ),
          // العدد
          Expanded(
            flex: 2,
            child: Text(
              '${item.selectQty}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          // سعر الوحدة
          Expanded(
            flex: 3,
            child: Text(
              item.price.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          // الإجمالي
          Expanded(
            flex: 3,
            child: Text(
              _formatNumber(item.price * item.selectQty),
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double n) {
    return n
        .toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  }
}
