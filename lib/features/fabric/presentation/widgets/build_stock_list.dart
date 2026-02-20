import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/features/fabric/data/models/fabric_stock_model.dart';
import 'package:hi_class_factory/features/fabric/presentation/manager/fabric_stock/fabric_stock_cubit.dart';
import 'package:hi_class_factory/features/fabric/presentation/widgets/add_fabric_stock_bottom_sheet.dart';
import 'package:hi_class_factory/features/fabric/presentation/widgets/stock_list_item.dart';

class BuildStockList extends StatefulWidget {
  const BuildStockList({super.key});

  @override
  State<BuildStockList> createState() => _BuildStockListState();
}

class _BuildStockListState extends State<BuildStockList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FabricStockCubit, FabricStockState>(
      builder: (context, state) {
        if (state is FabricStockLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FabricStockError) {
          return Center(child: Text(state.message));
        } else if (state is FabricStockSuccess) {
          final fabricStockList = state.fabricStockList;
          if (fabricStockList.isEmpty) {
            return const Center(child: Text("لا يوجد قماش"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: fabricStockList.length,
            itemBuilder: (context, index) {
              final item = fabricStockList[index];
              final cubit = context.read<FabricStockCubit>();
              return StockListItem(
                item: item,
                onEdit: (fabricStock) async {
                  final result = await showModalBottomSheet<FabricStockModel>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) =>
                        AddFabricStockBottomSheet(editFabricStock: fabricStock),
                  );
                  if (result != null) {
                    // setState(() => products[index] = result);
                    cubit.updateFabricStock(result);
                  }
                },
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("تأكيد الحذف"),
                      content: const Text("هل أنت متأكد أنك تريد الحذف؟"),
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
                    cubit.deleteFabricStock(item.id);
                  }
                },
              );
            },
          );
        } else {
          return const Center(child: Text("جار التحميل..."));
        }
      },
    );
  }
}
