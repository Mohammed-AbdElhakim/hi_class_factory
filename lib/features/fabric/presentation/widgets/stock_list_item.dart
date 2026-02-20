import 'package:flutter/material.dart';

import '../../data/models/fabric_stock_model.dart';
import 'color_widget.dart';

class StockListItem extends StatelessWidget {
  const StockListItem({super.key, required this.item, this.onDelete, this.onEdit});

  final FabricStockModel item;
  final VoidCallback? onDelete;
  final ValueChanged<FabricStockModel>? onEdit;

  @override
  Widget build(BuildContext context) {
    double progress = (item.quantity - item.cut) / item.quantity;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Color Box
            ColorWidget(color: item.color, colorName: item.colorName),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuButton<String>(
                        iconColor: Colors.black,
                        onSelected: (value) async {
                          if (value == "edit" && onEdit != null) {
                            onEdit!(item);
                          } else if (value == "delete" && onDelete != null) {
                            onDelete!();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: "edit", child: Text("تعديل")),
                          const PopupMenuItem(value: "delete", child: Text("حذف")),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Color Code: ${item.code}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  // Progress bar
                  LinearProgressIndicator(
                    value: progress,
                    color: item.status == StockLevel.low
                        ? Colors.orange
                        : item.status == StockLevel.full
                        ? Colors.red
                        : Colors.green,
                    backgroundColor: Colors.grey.shade300,

                    minHeight: 6,
                  ),
                  const SizedBox(height: 4),
                  // Stock and Cut
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item.quantity} kg"),
                      Text("Cut: ${item.cut}"),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.status == StockLevel.low
                              ? Colors.orange.shade100
                              : item.status == StockLevel.full
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.date,
                          style: TextStyle(
                            color: item.status == StockLevel.low
                                ? Colors.orange
                                : item.status == StockLevel.full
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
