import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/features/accessories/presentation/manager/accessories_cubit.dart';

import '../../../data/models/accessories_model.dart';
import '../../widgets/accessories_card.dart';
import '../../widgets/add_accessories_bottom_sheet.dart';

class AccessoriesMobileLayout extends StatefulWidget {
  const AccessoriesMobileLayout({super.key});

  @override
  State<AccessoriesMobileLayout> createState() => _AccessoriesMobileLayoutState();
}

class _AccessoriesMobileLayoutState extends State<AccessoriesMobileLayout> {
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
      body: BlocBuilder<AccessoriesCubit, AccessoriesState>(
        builder: (context, state) {
          if (state is AccessoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccessoriesError) {
            return Center(child: Text(state.message));
          } else if (state is AccessoriesSuccess) {
            final accessoriesList = state.accessories;
            if (accessoriesList.isEmpty) {
              return const Center(child: Text("لا يوجد اكسسوارات"));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: accessoriesList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final cubit = context.read<AccessoriesCubit>();
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
                      cubit.deleteAccessories(accessoriesList[index].id);
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
                      cubit.updateAccessories(result);
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("جار التحميل..."));
          }
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
    if (!mounted) return;
    if (result != null) {
      context.read<AccessoriesCubit>().addAccessories(result);
    }
  }
}
