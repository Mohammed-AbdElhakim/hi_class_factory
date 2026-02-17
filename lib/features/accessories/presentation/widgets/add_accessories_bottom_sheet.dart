import 'package:flutter/material.dart';

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
              const Text(
                "إضافة اكسسوار",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// الاكسسوار
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "اسم الاكسسوار",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 8),

              ///الكمية
              TextFormField(
                controller: qtyController,
                decoration: const InputDecoration(
                  labelText: "الكمية",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 8),

              ///المقاس
              TextFormField(
                controller: sizeController,
                decoration: const InputDecoration(
                  labelText: "المقاس",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),

              ///النوع
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: "النوع",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Text("اللون"),
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
                  widget.editAccessories == null ? "حفظ الاكسسوار" : "تعديل الاكسسوار",
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
