import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/bakr_model.dart';
import '../../manager/bakr_cubit.dart';
import '../../widgets/add_bakr_bottom_sheet.dart';
import '../../widgets/bakr_card.dart';

class BakrMobileLayout extends StatefulWidget {
  const BakrMobileLayout({super.key});

  @override
  State<BakrMobileLayout> createState() => _BakrMobileLayoutState();
}

class _BakrMobileLayoutState extends State<BakrMobileLayout> {
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
      body: BlocBuilder<BakrCubit, BakrState>(
        builder: (context, state) {
          if (state is BakrLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BakrError) {
            return Center(child: Text(state.message));
          } else if (state is BakrSuccess) {
            final bakr = state.bakr;
            if (bakr.isEmpty) {
              return const Center(child: Text("لا يوجد بكر"));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: bakr.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final cubit = context.read<BakrCubit>();
                return BakrCard(
                  bakr: bakr[index],
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
                      cubit.deleteBakr(bakr[index].id);
                    }
                  },

                  onEdit: (product) async {
                    final result = await showModalBottomSheet<BakrModel>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddBakrBottomSheet(editBakr: product),
                    );

                    if (result != null) {
                      cubit.updateBakr(result);
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

  void _openAddBakrSheet() async {
    final result = await showModalBottomSheet<BakrModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddBakrBottomSheet(),
    );
    if (!mounted) return;
    if (result != null) {
      context.read<BakrCubit>().addBakr(result);
    }
  }
}
