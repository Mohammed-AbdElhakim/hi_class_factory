import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/fabric_stock_model.dart';
import 'color_picker_dialog.dart';
import 'color_widget.dart';

class AddFabricStockBottomSheet extends StatefulWidget {
  const AddFabricStockBottomSheet({super.key, this.editFabricStock});
  final FabricStockModel? editFabricStock;
  @override
  State<AddFabricStockBottomSheet> createState() => _AddFabricStockBottomSheetState();
}

class _AddFabricStockBottomSheetState extends State<AddFabricStockBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorNameController = TextEditingController(text: "لون");
  final TextEditingController codeController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController cutController = TextEditingController();
  Color color = Colors.transparent;

  void _saveFabricStock() {
    if (!_formKey.currentState!.validate()) return;
    int qty = int.parse(qtyController.text);
    int cut = int.parse(cutController.text);
    final fabricStock = FabricStockModel(
      name: nameController.text,
      colorName: colorNameController.text,
      quantity: qty,
      cut: cut,
      color: color,
      id: widget.editFabricStock?.id ?? "",
      code: codeController.text,
      date: DateFormat('d/M/yyyy', 'en').format(DateTime.now()),
      status: (qty - cut) == 0
          ? StockLevel.full
          : (qty - cut) <= AppStrings.lowInStore
          ? StockLevel.low
          : StockLevel.normal,
    );

    Navigator.pop(context, fabricStock);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editFabricStock != null) {
      nameController.text = widget.editFabricStock!.name;
      colorNameController.text = widget.editFabricStock!.colorName;
      codeController.text = widget.editFabricStock!.code;
      cutController.text = widget.editFabricStock!.cut.toString();
      qtyController.text = widget.editFabricStock!.quantity.toString();
      color = widget.editFabricStock!.color;
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
              Center(
                child: const Text(
                  "إضافة قماش",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              /// الاسم
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "الاسم",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 8),

              /// الكود
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: "الكود",
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
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 8),

              ///المقطوع
              TextFormField(
                controller: cutController,
                decoration: const InputDecoration(
                  labelText: "الكميةالمقطوعة",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 8),

              ///اللون
              Column(
                children: [
                  Text("اللون"),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (_) => ColorPickerDialog(),
                      );

                      if (result != null) {
                        setState(() {
                          color = result["color"];
                          colorNameController.text = result["name"];
                        });
                      }
                    },
                    child: ColorWidget(color: color, colorName: colorNameController.text),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveFabricStock,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: Text(
                  widget.editFabricStock == null ? "حفظ" : "تعديل",
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
