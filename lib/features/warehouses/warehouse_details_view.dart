import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

////////////////////////////////////////////////////////////
/// DATA MODELS
////////////////////////////////////////////////////////////

class ProductModel {
  final String title;
  final String code;
  final List<SizeModel> sizes;

  const ProductModel({required this.title, required this.code, required this.sizes});

  int get totalUnits => sizes.fold(0, (sum, size) => sum + size.totalQty);
}

class SizeModel {
  final String size;
  final bool isLow;
  final List<ColorStock> colors;

  const SizeModel({required this.size, required this.colors, this.isLow = false});

  int get totalQty => colors.fold(0, (sum, color) => sum + color.qty);
}

class ColorStock {
  final String name;
  final int qty;
  final Color color;

  const ColorStock(this.name, this.qty, this.color);
}

////////////////////////////////////////////////////////////
/// SCREEN
////////////////////////////////////////////////////////////

class WarehouseDetailsView extends StatefulWidget {
  const WarehouseDetailsView({super.key});

  @override
  State<WarehouseDetailsView> createState() => _WarehouseDetailsViewState();
}

class _WarehouseDetailsViewState extends State<WarehouseDetailsView> {
  /*List<ProductModel> get products => List.generate(
    2,
    (index) => const ProductModel(
      title: "اسم الموديل",
      code: "MOD-OXF-2024",
      sizes: [
        SizeModel(
          size: "S",
          colors: [
            ColorStock("Navy", 85, Colors.blue),
            ColorStock("White", 57, Colors.grey),
          ],
        ),
        SizeModel(
          size: "M",
          isLow: true,
          colors: [
            ColorStock("Navy", 12, Colors.blue),
            ColorStock("White", 36, Colors.grey),
          ],
        ),
        SizeModel(
          size: "L",
          colors: [
            ColorStock("Black", 120, Colors.black),
            ColorStock("Beige", 174, Colors.brown),
          ],
        ),
        SizeModel(
          size: "XL",
          colors: [
            ColorStock("Gray", 200, Colors.grey),
            ColorStock("Blue", 158, Colors.blue),
          ],
        ),
      ],
    ),
  );*/
  final List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "مخزن المنتج النهائى",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProductSheet,
        child: const Icon(Icons.add),
      ),
      body: products.isEmpty
          ? const Center(child: Text("لا يوجد منتجات"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return InventoryCard(
                  product: products[index],
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("تأكيد الحذف"),
                        content: const Text("هل أنت متأكد أنك تريد حذف هذا المنتج؟"),
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
                      setState(() => products.removeAt(index));
                    }
                  },

                  onEdit: (product) async {
                    final result = await showModalBottomSheet<ProductModel>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddProductBottomSheet(editProduct: product),
                    );

                    if (result != null) {
                      setState(() => products[index] = result);
                    }
                  },
                );
              },
            ),
    );
  }

  void _openAddProductSheet() async {
    final result = await showModalBottomSheet<ProductModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddProductBottomSheet(),
    );

    if (result != null) {
      setState(() => products.add(result));
    }
  }
}

////////////////////////////////////////////////////////////
/// PRODUCT CARD
////////////////////////////////////////////////////////////

class InventoryCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onDelete;
  final ValueChanged<ProductModel>? onEdit;

  const InventoryCard({super.key, required this.product, this.onDelete, this.onEdit});

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
            child: const Icon(Icons.inventory_2),
          ),
          title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(product.code),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${product.totalUnits} Units",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit" && onEdit != null) {
                    onEdit!(product);
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
          children: product.sizes.map((size) => SizeTile(sizeModel: size)).toList(),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SIZE TILE
////////////////////////////////////////////////////////////

class SizeTile extends StatelessWidget {
  final SizeModel sizeModel;

  const SizeTile({super.key, required this.sizeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: sizeModel.isLow ? Colors.red.withValues(alpha: .07) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            "Size ${sizeModel.size}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            sizeModel.isLow
                ? "Low Stock: ${sizeModel.totalQty}"
                : "${sizeModel.totalQty} Units",
            style: TextStyle(
              color: sizeModel.isLow ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sizeModel.colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3.5,
                ),
                itemBuilder: (context, index) {
                  final c = sizeModel.colors[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 6, backgroundColor: c.color),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "${c.name} (${c.qty})",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// ADD PRODUCT BOTTOM SHEET
////////////////////////////////////////////////////////////

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

  final List<_SizeInputModel> sizes = [];

  void _addSize() {
    setState(() {
      sizes.add(_SizeInputModel());
    });
  }

  void _saveProduct() {
    if (!_formKey.currentState!.validate()) return;
    if (sizes.isEmpty) return;

    final product = ProductModel(
      title: titleController.text,
      code: codeController.text,
      sizes: sizes.map((sizeInput) {
        final total = sizeInput.colors.fold(
          0,
          (sum, c) => sum + int.parse(c.qtyController.text),
        );

        return SizeModel(
          size: sizeInput.sizeController.text,
          colors: sizeInput.colors
              .map(
                (c) => ColorStock(
                  c.nameController.text,
                  int.parse(c.qtyController.text),
                  c.selectedColor,
                ),
              )
              .toList(),
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
        final sizeInput = _SizeInputModel();
        sizeInput.sizeController.text = size.size;

        for (var color in size.colors) {
          final colorInput = _ColorInputModel();
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
                      (size) => _SizeInputWidget(
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

////////////////////////////////////////////////////////////
/// SIZE INPUT MODEL
////////////////////////////////////////////////////////////

class _SizeInputModel {
  final sizeController = TextEditingController();
  final List<_ColorInputModel> colors = [];

  void addColor() {
    colors.add(_ColorInputModel());
  }

  void removeColor(_ColorInputModel color) {
    color.dispose();
    colors.remove(color);
  }

  void dispose() {
    sizeController.dispose();
    for (final color in colors) {
      color.dispose();
    }
  }
}

class _ColorInputModel {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  Color selectedColor = Colors.grey;
  void dispose() {
    nameController.dispose();
    qtyController.dispose();
  }
}

////////////////////////////////////////////////////////////
/// SIZE INPUT WIDGET
////////////////////////////////////////////////////////////

class _SizeInputWidget extends StatefulWidget {
  final _SizeInputModel model;
  final VoidCallback onRemove;

  const _SizeInputWidget({required this.model, required this.onRemove});

  @override
  State<_SizeInputWidget> createState() => _SizeInputWidgetState();
}

class _SizeInputWidgetState extends State<_SizeInputWidget> {
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

  void _removeColor(_ColorInputModel color) {
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
                                    _ColorPickerDialog(initialColor: color.selectedColor),
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

/*class _ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  const _ColorPickerDialog({required this.initialColor});
  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color selected;
  final List<Color> presetColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.grey,
    Colors.teal,
    Colors.pink,
  ];
  @override
  void initState() {
    super.initState();
    selected = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر اللون"),
      content: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: presetColors.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() => selected = color);
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected == color ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, selected),
          child: const Text("تأكيد"),
        ),
      ],
    );
  }
}
*/

////////شغلك السابق//////
/*import 'package:flutter/material.dart';

class WarehouseDetailsView extends StatefulWidget {
  const WarehouseDetailsView({super.key});

  @override
  State<WarehouseDetailsView> createState() => _WarehouseDetailsViewState();
}

class _WarehouseDetailsViewState extends State<WarehouseDetailsView> {
  final List<InventoryCard> inventoryList = [
    InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "842 Units"),
    InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "842 Units"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "مخزن المنتج النهائى",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _openBottomSheet(context);
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: ListView.separated(
        itemCount: inventoryList.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) =>
            InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "842 Units"),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PRODUCT CARD الكونتينر الاساسى
class InventoryCard extends StatelessWidget {
  final String title;
  final String code;
  final String total;

  const InventoryCard({
    super.key,
    required this.title,
    required this.code,
    required this.total,
  });

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
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2),
          ),

          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          subtitle: Text(code),

          childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),

          children: const [
            /// Sizes
            SizeTile(
              size: "S",
              stock: "142 in stock",
              colors: [
                ColorStock("Navy", 85, Colors.blue),
                ColorStock("White", 57, Colors.grey),
              ],
            ),

            SizeTile(
              size: "M",
              stock: "Low Stock: 48",
              isLow: true,
              colors: [
                ColorStock("Navy", 12, Colors.blue),
                ColorStock("White", 36, Colors.grey),
              ],
            ),

            SizeTile(
              size: "L",
              stock: "294 Units",
              colors: [
                ColorStock("Black", 120, Colors.black),
                ColorStock("Beige", 174, Colors.brown),
              ],
            ),

            SizeTile(
              size: "XL",
              stock: "358 Units",
              colors: [
                ColorStock("Gray", 200, Colors.grey),
                ColorStock("Blue", 158, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
/// SIZE TILE  الكونتير الفرعى
class SizeTile extends StatelessWidget {
  final String size;
  final String stock;
  final bool isLow;
  final List<ColorStock> colors;

  const SizeTile({
    super.key,
    required this.size,
    required this.stock,
    required this.colors,
    this.isLow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isLow ? Colors.red.withOpacity(.07) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text("Size $size", style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(
            stock,
            style: TextStyle(
              color: isLow ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              child: Row(
                children: colors
                    .map(
                      (c) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(radius: 5, backgroundColor: c.color),
                              const SizedBox(width: 6),
                              Text("${c.name} (${c.qty})"),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            /// TOTAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(stock, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
/// COLOR MODEL   الالوان الاساسية
class ColorStock {
  final String name;
  final int qty;
  final Color color;

  const ColorStock(this.name, this.qty, this.color);
}

/////////////////////////////////////////////////////////
*/
