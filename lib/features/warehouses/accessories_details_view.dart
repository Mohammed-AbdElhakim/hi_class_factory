import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';

import '../../core/constants/app_colors.dart';

class AccessoriesModel {
  final String title;
  final Color? color;
  final String? size;
  final String? type;
  final bool isLow;
  final int qty;

  const AccessoriesModel({
    required this.title,
    required this.color,
    required this.size,
    required this.type,
    required this.qty,
    required this.isLow,
  });
}

class AccessoriesDetailsView extends StatefulWidget {
  const AccessoriesDetailsView({super.key});

  @override
  State<AccessoriesDetailsView> createState() => _AccessoriesDetailsViewState();
}

class _AccessoriesDetailsViewState extends State<AccessoriesDetailsView> {
  final List<AccessoriesModel> accessoriesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "مخزن الاكسسوارات",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddAccessoriesSheet,
        child: const Icon(Icons.add),
      ),
      body: accessoriesList.isEmpty
          ? const Center(child: Text("لا يوجد اكسسوارات"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: accessoriesList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return AccessoriesCard(
                  accessories: accessoriesList[index],
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
                      setState(() => accessoriesList.removeAt(index));
                    }
                  },

                  onEdit: (accessories) async {
                    final result = await showModalBottomSheet<AccessoriesModel>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) =>
                          AddAccessoriesBottomSheet(editAccessories: accessories),
                    );

                    if (result != null) {
                      setState(() => accessoriesList[index] = result);
                    }
                  },
                );
              },
            ),
    );
  }

  void _openAddAccessoriesSheet() async {
    final result = await showModalBottomSheet<AccessoriesModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddAccessoriesBottomSheet(),
    );

    if (result != null) {
      setState(() => accessoriesList.add(result));
    }
  }
}

class AccessoriesCard extends StatelessWidget {
  final AccessoriesModel accessories;
  final VoidCallback? onDelete;
  final ValueChanged<AccessoriesModel>? onEdit;

  const AccessoriesCard({
    super.key,
    required this.accessories,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              accessories.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (accessories.color != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 6),
                    child: CircleAvatar(radius: 8, backgroundColor: accessories.color!),
                  ),

                if (accessories.size != "")
                  Text(
                    "${accessories.size}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (accessories.type != "")
                  Text(
                    "${accessories.type}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.widgets),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${accessories.qty} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == "edit" && onEdit != null) {
                      onEdit!(accessories);
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ],
      ),
    );
  }
}

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
                        builder: (_) => _ColorPickerDialog(),
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

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog();

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  Color selected = Colors.transparent;

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
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
          onPressed: () {
            Navigator.pop(context, selected);
          },
          child: const Text("تأكيد"),
        ),
      ],
    );
  }
}
