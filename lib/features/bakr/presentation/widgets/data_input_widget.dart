import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../data/models/data_input_model.dart';
import 'color_picker_dialog.dart';

class DataInputWidget extends StatefulWidget {
  final DataInputModel model;
  final VoidCallback onRemove;
  final Color initialColor;

  const DataInputWidget({
    super.key,
    required this.model,
    required this.onRemove,
    required this.initialColor,
  });

  @override
  State<DataInputWidget> createState() => _DataInputWidgetState();
}

class _DataInputWidgetState extends State<DataInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 20, end: 0, start: 12, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.model.codeController,
                    decoration: InputDecoration(
                      labelText: S.of(context).code,
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? S.of(context).required : null,
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

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(S.of(context).color),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () async {
                          final result = await showDialog<Color>(
                            context: context,
                            builder: (_) => ColorPickerDialog(
                              initialColor: widget.model.selectedColor,
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              widget.model.selectedColor = result;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: 18,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: widget.model.selectedColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  /// QTY
                  Expanded(
                    child: TextFormField(
                      controller: widget.model.qtyController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: S.of(context).quantity,
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? S.of(context).required : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
