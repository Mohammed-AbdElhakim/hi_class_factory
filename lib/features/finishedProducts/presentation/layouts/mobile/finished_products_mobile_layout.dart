import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';
import '../../widgets/add_product_bottom_sheet.dart';
import '../../widgets/inventory_card.dart';

class FinishedProductsMobileLayout extends StatefulWidget {
  const FinishedProductsMobileLayout({super.key});

  @override
  State<FinishedProductsMobileLayout> createState() =>
      _FinishedProductsMobileLayoutState();
}

class _FinishedProductsMobileLayoutState extends State<FinishedProductsMobileLayout> {
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
