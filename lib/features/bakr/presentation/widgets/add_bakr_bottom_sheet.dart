import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/bakr_data_model.dart';
import '../../data/models/bakr_model.dart';
import '../../data/models/data_input_model.dart';
import 'data_input_widget.dart';

class AddBakrBottomSheet extends StatefulWidget {
  const AddBakrBottomSheet({super.key, this.editBakr});
  final BakrModel? editBakr;
  @override
  State<AddBakrBottomSheet> createState() => _AddBakrBottomSheetState();
}

class _AddBakrBottomSheetState extends State<AddBakrBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  final List<DataInputModel> dataList = [];

  void _addData() {
    setState(() {
      dataList.add(DataInputModel());
    });
  }

  void _saveBakr() {
    if (!_formKey.currentState!.validate()) return;
    if (dataList.isEmpty) return;

    final bakr = BakrModel(
      id: widget.editBakr?.id ?? "",
      title: titleController.text,
      bakrData: dataList.map((dataInput) {
        int qty = int.parse(dataInput.qtyController.text);
        return BakrDataModel(
          code: dataInput.codeController.text,
          color: dataInput.selectedColor,
          isLow: qty < AppStrings.lowInStore,
          qty: qty,
        );
      }).toList(),
    );

    Navigator.pop(context, bakr);
  }

  @override
  void initState() {
    super.initState();
    if (widget.editBakr != null) {
      titleController.text = widget.editBakr!.title;

      for (var data in widget.editBakr!.bakrData) {
        final dataInput = DataInputModel();
        dataInput.codeController.text = data.code;
        dataInput.qtyController.text = data.qty.toString();
        dataInput.selectedColor = data.color;

        dataList.add(dataInput);
      }
    } else if (dataList.isEmpty) {
      _addData();
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
                "إضافة بكر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// PRODUCT INFO
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "اسم الخيط",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "مطلوب" : null,
              ),

              const SizedBox(height: 20),

              Column(
                children: dataList
                    .map(
                      (data) => DataInputWidget(
                        initialColor: data.selectedColor,
                        model: data,
                        onRemove: () => setState(() => dataList.remove(data)),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _addData,
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.darkCard,
                  elevation: 5,
                  // backgroundColor: AppColors.darkCard.withValues(alpha: .5),
                ),
                icon: const Icon(Icons.add),
                label: const Text("إضافة لون"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveBakr,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  minimumSize: const Size(double.infinity, 35),
                ),
                child: Text(
                  widget.editBakr == null ? "حفظ الخيط" : "تعديل الخيط",
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
