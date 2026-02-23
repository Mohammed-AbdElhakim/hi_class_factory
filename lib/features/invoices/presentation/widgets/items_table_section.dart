import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_colors.dart';

import '../../data/models/select_product_model.dart';
import 'item_row.dart';

class ItemsTableSection extends StatelessWidget {
  const ItemsTableSection({
    super.key,
    required this.listProduct,
    this.onTapDelete,
    this.isDelete = true,
  });
  final List<SelectProductModel> listProduct;
  final void Function(int index)? onTapDelete;
  final bool isDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        // color: const Color(0xFF2A1200),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkCard,
            offset: Offset(1, 1),
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        children: [
          // رأس الجدول والاساسى من هنا
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.brown,
              // color: Theme.of(context).colorScheme.surface,

              // color: Color(0xFF3A1800),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                if (isDelete) SizedBox(width: 25),
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
          ...listProduct.asMap().entries.map((entry) {
            int index = entry.key; // ده الـ index
            var item = entry.value; // ده العنصر
            return Row(
              children: [
                if (isDelete) SizedBox(width: 8),
                if (isDelete)
                  InkWell(
                    onTap: () => onTapDelete?.call(index), // بعت الـ index
                    child: Icon(Icons.cancel, size: 20, color: Colors.red.shade900),
                  ),
                Expanded(child: ItemRow(item: item)),
              ],
            );
          }),
        ],
      ),
    );
  }
}
