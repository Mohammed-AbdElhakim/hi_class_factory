import 'package:flutter/material.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/accessories_model.dart';
import 'color_picker_dialog.dart';

class AddAccessoriesBottomSheet extends StatefulWidget {
  const AddAccessoriesBottomSheet({super.key, this.editAccessories});
  final AccessoriesModel? editAccessories;
  @override
  State<AddAccessoriesBottomSheet> createState() => _AddAccessoriesBottomSheetState();
}

class _AddAccessoriesBottomSheetState extends State<AddAccessoriesBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  Color? color;

  void _saveBakr() {
    if (!_formKey.currentState!.validate()) return;
    int qty = int.parse(qtyController.text);
    final bakr = AccessoriesModel(
      title: titleController.text,
      size: sizeController.text,
      isLow: qty < AppStrings.lowInStore,
      qty: qty,
      type: typeController.text,
      color: color,
      id: widget.editAccessories?.id ?? "",
    );

    Navigator.pop(context, bakr);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editAccessories != null) {
      titleController.text = widget.editAccessories!.title;
      sizeController.text = widget.editAccessories!.size ?? "";
      typeController.text = widget.editAccessories!.type ?? "";
      qtyController.text = widget.editAccessories!.qty.toString();
      color = widget.editAccessories!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).add_accessory,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// الاكسسوار
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: S.of(context).accessory_name,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? S.of(context).required : null,
              ),
              const SizedBox(height: 8),

              ///الكمية
              TextFormField(
                controller: qtyController,
                decoration: InputDecoration(
                  labelText: S.of(context).quantity,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? S.of(context).required : null,
              ),
              const SizedBox(height: 8),

              ///المقاس
              TextFormField(
                controller: sizeController,
                decoration: InputDecoration(
                  labelText: S.of(context).size,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              ///النوع
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(
                  labelText: S.of(context).type,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Text(S.of(context).color),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog<Color>(
                        context: context,
                        builder: (_) => ColorPickerDialog(),
                      );

                      if (result != null) {
                        setState(() {
                          color = result;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 18,
                      child: CircleAvatar(radius: 16, backgroundColor: color),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveBakr,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: Text(
                  widget.editAccessories == null
                      ? S.of(context).save_accessory
                      : S.of(context).edit_accessory,
                  style: TextStyle(color: AppColors.textWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
