import 'package:flutter/material.dart';

import '../../../finishedProducts/data/models/size_model.dart';
import '../../data/models/select_item_model.dart';

class SizeItem extends StatefulWidget {
  const SizeItem({super.key, required this.itemSize, required this.onTap});

  final SizeModel itemSize;
  final void Function(SelectItemModel? selectItem) onTap;

  @override
  State<SizeItem> createState() => _SizeItemState();
}

class _SizeItemState extends State<SizeItem> {
  bool isSelected = false;
  SelectItemModel? selectItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(widget.itemSize.size),
            ),

            Expanded(
              child: Wrap(
                children: widget.itemSize.colors
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = !isSelected;
                              if (isSelected) {
                                selectItem = SelectItemModel(
                                  size: widget.itemSize.size,
                                  qty: e.qty,
                                  color: e.name,
                                );
                              } else {
                                selectItem = null;
                              }
                            });

                            widget.onTap(selectItem);
                          },
                          child: CircleAvatar(
                            radius: 24,
                            // backgroundColor: Colors.red,
                            child: CircleAvatar(
                              radius: 22,
                              // backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: e.color,
                                child: Text(
                                  e.qty.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: e.color == Colors.white
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
