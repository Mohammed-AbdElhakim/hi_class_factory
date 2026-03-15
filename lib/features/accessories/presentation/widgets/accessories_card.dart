import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/accessories_model.dart';
import 'accessories_data_tile.dart';

class AccessoriesCard extends StatelessWidget {
  final AccessoriesModel accessories;
  final VoidCallback? onDelete;
  final ValueChanged<AccessoriesModel>? onEdit;

  const AccessoriesCard({
    super.key,
    required this.accessories,
    this.onDelete,
    this.onEdit,
  });

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
            child: const Icon(Icons.widgets),
          ),
          title: Text(
            accessories.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == "edit" && onEdit != null) {
                onEdit!(accessories);
              } else if (value == "delete" && onDelete != null) {
                onDelete!();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "edit", child: Text(S.of(context).edit)),
              PopupMenuItem(value: "delete", child: Text(S.of(context).delete)),
            ],
          ),
          childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          children: [AccessoriesDataTile(accessories: accessories)],
        ),
      ),
    );
  }
}
