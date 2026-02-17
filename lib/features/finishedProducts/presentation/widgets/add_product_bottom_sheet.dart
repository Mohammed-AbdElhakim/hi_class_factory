import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/color_input_model.dart';
import '../../data/models/color_stock.dart';
import '../../data/models/product_model.dart';
import '../../data/models/size_input_model.dart';
import '../../data/models/size_model.dart';
import 'size_input_widget.dart';

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({super.key, this.editProduct});
  final ProductModel? editProduct;
  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final codeController = TextEditingController();

  final List<SizeInputModel> sizes = [];

  void _addSize() {
    setState(() {
      sizes.add(SizeInputModel());
    });
  }

  void _saveProduct() {
    if (!_formKey.currentState!.validate()) return;
    if (sizes.isEmpty) return;

    final product = ProductModel(
      id: widget.editProduct?.id ?? "",
      title: titleController.text,
      code: codeController.text,
      sizes: sizes.map((sizeInput) {
        final total = sizeInput.colors.fold(
          0,
          (sum, c) => sum + int.parse(c.qtyController.text),
        );

        return SizeModel(
          size: sizeInput.sizeController.text,
          colors: sizeInput.colors.map((c) {
            return ColorStock(
              c.nameController.text,
              int.parse(c.qtyController.text),
              c.selectedColor,
            );
          }).toList(),
          isLow: total < 20,
        );
      }).toList(),
    );

    Navigator.pop(context, product);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editProduct != null) {
      titleController.text = widget.editProduct!.title;
      codeController.text = widget.editProduct!.code;

      for (var size in widget.editProduct!.sizes) {
        final sizeInput = SizeInputModel();
        sizeInput.sizeController.text = size.size;

        for (var color in size.colors) {
          final colorInput = ColorInputModel();
          colorInput.nameController.text = color.name;
          colorInput.qtyController.text = color.qty.toString();
          colorInput.selectedColor = color.color;
          sizeInput.colors.add(colorInput);
        }

        sizes.add(sizeInput);
      }
    } else if (sizes.isEmpty) {
      _addSize();
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
            children: [
              const Text(
                "إضافة منتج",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// PRODUCT INFO
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "اسم المنتج",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: "كود المنتج",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),
              const SizedBox(height: 20),

              /// SIZES
              Column(
                children: sizes
                    .map(
                      (size) => SizeInputWidget(
                        model: size,
                        onRemove: () => setState(() => sizes.remove(size)),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _addSize,
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.darkCard,
                  elevation: 5,
                  // backgroundColor: AppColors.darkCard.withValues(alpha: .5),
                ),
                icon: const Icon(Icons.add),
                label: const Text("إضافة مقاس"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: Text(
                  widget.editProduct == null ? "حفظ المنتج" : "تعديل المنتج",
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
