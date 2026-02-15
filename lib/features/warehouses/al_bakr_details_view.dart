import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class BakrModel {
  final String title;
  final List<BakrDataModel> bakrData;

  const BakrModel({required this.title, required this.bakrData});

  int get totalQty => bakrData.fold(0, (sum, data) => sum + data.qty);
}

class BakrDataModel {
  final String code;
  final Color color;
  final bool isLow;
  final int qty;

  const BakrDataModel({
    required this.color,
    required this.code,
    required this.qty,
    required this.isLow,
  });
}

class AlBakrDetailsView extends StatefulWidget {
  const AlBakrDetailsView({super.key});

  @override
  State<AlBakrDetailsView> createState() => _AlBakrDetailsViewState();
}

class _AlBakrDetailsViewState extends State<AlBakrDetailsView> {
  final List<BakrModel> bakrs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("مخزن البكر", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddBakrSheet,
        child: const Icon(Icons.add),
      ),
      body: bakrs.isEmpty
          ? const Center(child: Text("لا يوجد بكر"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: bakrs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return BakrCard(
                  bakr: bakrs[index],
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("تأكيد الحذف"),
                        content: const Text("هل أنت متأكد أنك تريد حذف هذا ؟"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("إلغاء"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("حذف"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      setState(() => bakrs.removeAt(index));
                    }
                  },

                  onEdit: (product) async {
                    final result = await showModalBottomSheet<BakrModel>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddBakrBottomSheet(editBakr: product),
                    );

                    if (result != null) {
                      setState(() => bakrs[index] = result);
                    }
                  },
                );
              },
            ),
    );
  }

  void _openAddBakrSheet() async {
    final result = await showModalBottomSheet<BakrModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddBakrBottomSheet(),
    );

    if (result != null) {
      setState(() => bakrs.add(result));
    }
  }
}

class BakrCard extends StatelessWidget {
  final BakrModel bakr;
  final VoidCallback? onDelete;
  final ValueChanged<BakrModel>? onEdit;

  const BakrCard({super.key, required this.bakr, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.cyclone),
          ),
          title: Text(bakr.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${bakr.totalQty} ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit" && onEdit != null) {
                    onEdit!(bakr);
                  } else if (value == "delete" && onDelete != null) {
                    onDelete!();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: "edit", child: Text("تعديل")),
                  const PopupMenuItem(value: "delete", child: Text("حذف")),
                ],
              ),
            ],
          ),

          // Text(
          //   "${product.totalUnits} Units",
          //   style: const TextStyle(fontWeight: FontWeight.bold),
          // ),
          childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          children: bakr.bakrData
              .map((itemModel) => BakrTile(bakrDataModel: itemModel))
              .toList(),
        ),
      ),
    );
  }
}

class BakrTile extends StatelessWidget {
  final BakrDataModel bakrDataModel;

  const BakrTile({super.key, required this.bakrDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: bakrDataModel.isLow
            ? Colors.red.withValues(alpha: .07)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 18,
            child: CircleAvatar(radius: 16, backgroundColor: bakrDataModel.color),
          ),
          Text(bakrDataModel.code, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            "الكمية: ${bakrDataModel.qty}",
            style: TextStyle(
              color: bakrDataModel.isLow ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AddBakrBottomSheet extends StatefulWidget {
  const AddBakrBottomSheet({super.key, this.editBakr});
  final BakrModel? editBakr;
  @override
  State<AddBakrBottomSheet> createState() => _AddBakrBottomSheetState();
}

class _AddBakrBottomSheetState extends State<AddBakrBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  final List<_DataInputModel> dataList = [];

  void _addData() {
    setState(() {
      dataList.add(_DataInputModel());
    });
  }

  void _saveBakr() {
    if (!_formKey.currentState!.validate()) return;
    if (dataList.isEmpty) return;

    final bakr = BakrModel(
      title: titleController.text,
      bakrData: dataList.map((dataInput) {
        int qty = int.parse(dataInput.qtyController.text);
        return BakrDataModel(
          code: dataInput.codeController.text,
          color: dataInput.selectedColor,
          isLow: qty < 20,
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
        final dataInput = _DataInputModel();
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
                      (data) => _DataInputWidget(
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

class _DataInputModel {
  final codeController = TextEditingController();
  final qtyController = TextEditingController();
  Color selectedColor = Colors.grey;
  void dispose() {
    codeController.dispose();
    qtyController.dispose();
  }
}

class _DataInputWidget extends StatefulWidget {
  final _DataInputModel model;
  final VoidCallback onRemove;
  final Color initialColor;

  const _DataInputWidget({
    required this.model,
    required this.onRemove,
    required this.initialColor,
  });

  @override
  State<_DataInputWidget> createState() => _DataInputWidgetState();
}

class _DataInputWidgetState extends State<_DataInputWidget> {
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
                    decoration: const InputDecoration(
                      labelText: "الكود",
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

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text("اللون"),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () async {
                          final result = await showDialog<Map<String, dynamic>>(
                            context: context,
                            builder: (_) => _ColorPickerDialog(
                              initialColor: widget.model.selectedColor,
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              widget.model.selectedColor = result["color"];
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
                      decoration: const InputDecoration(
                        labelText: "الكمية",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
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

class _ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const _ColorPickerDialog({required this.initialColor});

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color selected;

  final Map<Color, String> colorNames = {
    Colors.red: "أحمر",
    Colors.green: "أخضر",
    Colors.blue: "أزرق",
    Colors.yellow: "أصفر",
    Colors.orange: "برتقالي",
    Colors.purple: "بنفسجي",
    Colors.black: "أسود",
    Colors.white: "أبيض",
    Colors.brown: "بني",
    Colors.grey: "رمادي",
    Colors.teal: "تركوازي",
    Colors.pink: "زهري",
    Colors.cyan: "سماوي",
    Colors.indigo: "نيلي",
    Colors.lime: "ليموني",
    Colors.amber: "كهرماني",
    Colors.deepOrange: "برتقالي غامق",
    Colors.deepPurple: "بنفسجي غامق",
    Colors.lightBlue: "أزرق فاتح",
    Colors.lightGreen: "أخضر فاتح",
    Colors.blueGrey: "أزرق رمادي",
    Colors.redAccent: "أحمر فاتح",
    Colors.greenAccent: "أخضر فاتح",
    Colors.blueAccent: "أزرق فاتح",
    Colors.yellowAccent: "أصفر فاتح",
    Colors.orangeAccent: "برتقالي فاتح",
    Colors.purpleAccent: "بنفسجي فاتح",
    Colors.pinkAccent: "زهري فاتح",
  };

  @override
  void initState() {
    super.initState();
    selected = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر اللون"),
      content: SizedBox(
        width: double.maxFinite,
        // تحديد أقصى ارتفاع
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: colorNames.entries.map((entry) {
              final color = entry.key;
              final name = entry.value;
              final isSelected = selected == color;

              return Container(
                padding: isSelected ? EdgeInsets.symmetric(vertical: 8) : EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? AppColors.background.withValues(alpha: .15)
                      : Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => selected = color),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   color: isSelected ? Colors.black : Colors.transparent,
                          //   width: 2,
                          // ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 50,
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.pop(context, {"color": selected, "name": colorNames[selected]!}),
          child: const Text("تأكيد"),
        ),
      ],
    );
  }
}
