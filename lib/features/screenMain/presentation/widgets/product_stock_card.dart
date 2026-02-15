import 'package:flutter/material.dart';

class ProductStockCard extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String stockCount;
  final String imagePath;
  final String categoryName;
  final List<ProductColor> colors;
  final VoidCallback onManageStock;
  final VoidCallback onEdit;

  const ProductStockCard({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.stockCount,
    required this.imagePath,
    required this.categoryName,
    required this.colors,
    required this.onManageStock,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ExpansionTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(productName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("SIZE: $categoryName"),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// colors
                const Text("AVAILABLE COLORS", style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                Row(
                  children: colors.map((color) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(radius: 10, backgroundColor: color.colorValue),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// stock
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("STOCK LEVEL", style: TextStyle(color: Colors.grey)),
                    Text(
                      "$stockCount units",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onManageStock,
                        child: const Text("Manage Stock"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductColor {
  final Color colorValue;
  final Color borderColor;
  final String count;

  const ProductColor({
    required this.colorValue,
    required this.borderColor,
    required this.count,
  });
}
