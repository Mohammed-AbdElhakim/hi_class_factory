import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../data/models/product_model.dart';
import 'size_tile.dart';

class InventoryCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onDelete;
  final ValueChanged<ProductModel>? onEdit;

  const InventoryCard({super.key, required this.product, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2),
          ),
          title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(product.code),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${product.totalUnits} Units",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit" && onEdit != null) {
                    onEdit!(product);
                  } else if (value == "delete" && onDelete != null) {
                    onDelete!();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: "edit", child: Text(S.of(context).edit)),
                  PopupMenuItem(value: "delete", child: Text(S.of(context).delete)),
                ],
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          children: product.sizes.map((size) => SizeTile(sizeModel: size)).toList(),
        ),
      ),
    );
  }
}
