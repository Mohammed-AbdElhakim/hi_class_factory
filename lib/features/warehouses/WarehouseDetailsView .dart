import 'package:flutter/material.dart';

class WarehouseDetailsView extends StatefulWidget {
  const WarehouseDetailsView({super.key});

  @override
  State<WarehouseDetailsView> createState() => _WarehouseDetailsViewState();
}

class _WarehouseDetailsViewState extends State<WarehouseDetailsView> {
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
        onPressed: () {
          _openBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "842 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "1,250 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
          SizedBox(height: 16),
          InventoryCard(title: "اسم الموديل", code: "MOD-OXF-2024", total: "115 Units"),
        ],
      ),
    );
  }

  ///////////////////////////////
  ///bottom Sheet
  //////////////////////////////
  void _openBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter Your Data',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                /// Name Field
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Email Field
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        // name = nameController.text;
                        // email = emailController.text;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  final List<ModelItem> models = [];

  void addModel() {
    setState(() {
      models.add(ModelItem());
    });
  }

  void addSize(int modelIndex) {
    setState(() {
      models[modelIndex].sizes.add(SizeItem());
    });
  }

  void addColor(int modelIndex, int sizeIndex) {
    setState(() {
      models[modelIndex].sizes[sizeIndex].colors.add(ColorItem());
    });
  }

  void submitData() {
    for (var model in models) {
      debugPrint("Model: ${model.modelController.text}");
      for (var size in model.sizes) {
        debugPrint("  Size: ${size.sizeController.text}");
        for (var color in size.colors) {
          debugPrint(
            "    Color: ${color.colorController.text} - Qty: ${color.quantityController.text}",
          );
        }
      }
    }
  }
}

//////////////////////
/// =================== DATA MODELS ===================
//////////////////////

/// =================== DATA MODELS ===================

class ColorItem {
  TextEditingController colorController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
}

class SizeItem {
  TextEditingController sizeController = TextEditingController();
  List<ColorItem> colors = [];
}

class ModelItem {
  TextEditingController modelController = TextEditingController();
  List<SizeItem> sizes = [];
}

////////////////////////////////////////////////////////////
/// PRODUCT CARD الكونتينر الاساسى
////////////////////////////////////////////////////////////

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
/// SIZE TILE  الكونتير الفرعى
////////////////////////////////////////////////////////////

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
/// COLOR MODEL   الالوان الاساسية
////////////////////////////////////////////////////////////

class ColorStock {
  final String name;
  final int qty;
  final Color color;

  const ColorStock(this.name, this.qty, this.color);
}
