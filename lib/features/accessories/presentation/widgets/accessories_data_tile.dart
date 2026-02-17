import 'package:flutter/material.dart';

import '../../data/models/accessories_model.dart';

class AccessoriesDataTile extends StatelessWidget {
  const AccessoriesDataTile({super.key, required this.accessories});
  final AccessoriesModel accessories;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: accessories.isLow
            ? Colors.red.withValues(alpha: .07)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (accessories.color != null)
                    Expanded(
                      child: CircleAvatar(radius: 8, backgroundColor: accessories.color!),
                    ),

                  if (accessories.size != "")
                    Expanded(
                      child: Text(
                        "${accessories.size}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (accessories.type != "")
                    Expanded(
                      child: Text(
                        "${accessories.type}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              "الكمية: ${accessories.qty} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
