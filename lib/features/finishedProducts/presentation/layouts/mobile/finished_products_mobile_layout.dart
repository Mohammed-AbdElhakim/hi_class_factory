import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/models/product_model.dart';
import '../../manager/finished_products_cubit.dart';
import '../../widgets/add_product_bottom_sheet.dart';
import '../../widgets/inventory_card.dart';

class FinishedProductsMobileLayout extends StatefulWidget {
  const FinishedProductsMobileLayout({super.key});

  @override
  State<FinishedProductsMobileLayout> createState() =>
      _FinishedProductsMobileLayoutState();
}

class _FinishedProductsMobileLayoutState extends State<FinishedProductsMobileLayout> {
  // final List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).finishedProductsStore,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProductSheet,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<FinishedProductsCubit, FinishedProductsState>(
        builder: (context, state) {
          if (state is FinishedProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinishedProductsError) {
            return Center(child: Text(state.message));
          } else if (state is FinishedProductsSuccess) {
            final products = state.products;
            if (products.isEmpty) {
              return Center(child: Text(S.of(context).noProducts));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final cubit = context.read<FinishedProductsCubit>();
                return InventoryCard(
                  product: products[index],
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(S.of(context).deleteConfirmation),
                        content: Text(S.of(context).deleteProductQuestion),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(S.of(context).cancel),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(S.of(context).delete),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      // setState(() => products.removeAt(index));
                      cubit.deleteFinishedProduct(products[index].id);
                    }
                  },

                  onEdit: (product) async {
                    final result = await showModalBottomSheet<ProductModel>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => AddProductBottomSheet(editProduct: product),
                    );
                    if (result != null) {
                      // setState(() => products[index] = result);
                      cubit.updateFinishedProduct(result);
                    }
                  },
                );
              },
            );
          } else {
            return Center(child: Text(S.of(context).loading));
          }
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
    if (!mounted) return;
    if (result != null) {
      // setState(() => products.add(result));
      context.read<FinishedProductsCubit>().addFinishedProduct(result);
    }
  }
}
