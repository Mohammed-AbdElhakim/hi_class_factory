import 'package:flutter/material.dart';

class BuildStockList extends StatefulWidget {
  const BuildStockList({super.key});

  @override
  State<BuildStockList> createState() => _BuildStockListState();
}

class _BuildStockListState extends State<BuildStockList> {
  final List<Map<String, dynamic>> stockItems = [
    {
      'name': 'اسم الصنف',
      'color': Colors.red,
      'colorName': 'RED',
      'code': '#RD-204',
      'quantity': 450,
      'cut': 350,
      'status': '2/2/2026',
    },
    {
      'name': 'اسم الصنف',
      'color': Colors.teal,
      'colorName': 'teal',
      'code': '#TD-202',
      'quantity': 300,
      'cut': 200,
      'status': '10/2/2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: stockItems.length,
      itemBuilder: (context, index) {
        final item = stockItems[index];
        double progress = item['quantity'] / (item['quantity'] + item['cut']);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Color Box
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      item['colorName'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Item Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Color Code: ${item['code']}",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      // Progress bar
                      LinearProgressIndicator(
                        value: progress,
                        color: item['status'] == 'LOW STOCK'
                            ? Colors.orange
                            : item['status'] == 'CRITICAL'
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
                          Text("${item['quantity']} kg"),
                          Text("Cut: ${item['cut']}"),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: item['status'] == 'date'
                                  ? Colors.orange.shade100
                                  : item['status'] == 'CRITICAL'
                                  ? Colors.red.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                color: item['status'] == 'LOW STOCK'
                                    ? Colors.orange
                                    : item['status'] == 'CRITICAL'
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
      },
    );
  }
}
