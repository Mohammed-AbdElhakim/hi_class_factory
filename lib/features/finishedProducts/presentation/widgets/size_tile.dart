import 'package:flutter/material.dart';

import '../../data/models/size_model.dart';

class SizeTile extends StatelessWidget {
  final SizeModel sizeModel;

  const SizeTile({super.key, required this.sizeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: sizeModel.isLow ? Colors.red.withValues(alpha: .07) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            "Size ${sizeModel.size}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            sizeModel.isLow
                ? "Low Stock: ${sizeModel.totalQty}"
                : "${sizeModel.totalQty} Units",
            style: TextStyle(
              color: sizeModel.isLow ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sizeModel.colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3.5,
                ),
                itemBuilder: (context, index) {
                  final c = sizeModel.colors[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 6, backgroundColor: c.color),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "${c.name} (${c.qty})",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
