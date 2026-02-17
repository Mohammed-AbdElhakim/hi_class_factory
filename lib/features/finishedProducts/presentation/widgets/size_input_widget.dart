import 'package:flutter/material.dart';

import '../../data/models/color_input_model.dart';
import '../../data/models/size_input_model.dart';
import 'color_picker_dialog.dart';

class SizeInputWidget extends StatefulWidget {
  final SizeInputModel model;
  final VoidCallback onRemove;

  const SizeInputWidget({super.key, required this.model, required this.onRemove});

  @override
  State<SizeInputWidget> createState() => SizeInputWidgetState();
}

class SizeInputWidgetState extends State<SizeInputWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.model.colors.isEmpty) {
      widget.model.addColor();
    }
  }

  void _addColor() {
    setState(() => widget.model.addColor());
  }

  void _removeColor(ColorInputModel color) {
    setState(() => widget.model.removeColor(color));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 20, end: 0, start: 12, bottom: 8),
        child: Column(
          children: [
            /// SIZE ROW
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.model.sizeController,
                    decoration: const InputDecoration(
                      labelText: "المقاس",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? "مطلوب" : null,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.model.dispose();
                    widget.onRemove();
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// COLORS
            Column(
              children: widget.model.colors.map((color) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      /// COLOR PREVIEW + PICKER
                      /* GestureDetector(
                        onTap: () async {
                          final picked = await showDialog<Color>(
                            context: context,
                            builder: (_) =>
                                _ColorPickerDialog(initialColor: color.selectedColor),
                          );

                          if (picked != null) {
                            setState(() {
                              color.selectedColor = picked;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: color.selectedColor,
                        ),
                      ),*/
                      Column(
                        children: [
                          Text("اللون"),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () async {
                              final result = await showDialog<Map<String, dynamic>>(
                                context: context,
                                builder: (_) =>
                                    ColorPickerDialog(initialColor: color.selectedColor),
                              );

                              if (result != null) {
                                setState(() {
                                  color.selectedColor = result["color"];
                                  color.nameController.text = result["name"];
                                });
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: color.selectedColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 8),

                      // /// NAME
                      // Expanded(
                      //   child: TextFormField(
                      //     controller: color.nameController,
                      //     decoration: const InputDecoration(
                      //       enabled: false,
                      //       labelText: "اللون",
                      //       border: OutlineInputBorder(),
                      //     ),
                      //     validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                      //   ),
                      // ),
                      const SizedBox(width: 8),

                      /// QTY
                      Expanded(
                        child: TextFormField(
                          controller: color.qtyController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "الكمية",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// DELETE
                      IconButton(
                        onPressed: () => _removeColor(color),
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            TextButton.icon(
              onPressed: _addColor,
              icon: const Icon(Icons.add),
              label: const Text("إضافة لون"),
            ),
          ],
        ),
      ),
    );
  }
}
