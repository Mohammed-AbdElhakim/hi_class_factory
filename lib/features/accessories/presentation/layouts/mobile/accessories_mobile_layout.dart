import 'package:flutter/material.dart';

import '../../../data/models/accessories_model.dart';
import '../../widgets/accessories_card.dart';
import '../../widgets/add_accessories_bottom_sheet.dart';

class AccessoriesMobileLayout extends StatefulWidget {
  const AccessoriesMobileLayout({super.key});

  @override
  State<AccessoriesMobileLayout> createState() => _AccessoriesMobileLayoutState();
}

class _AccessoriesMobileLayoutState extends State<AccessoriesMobileLayout> {
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
