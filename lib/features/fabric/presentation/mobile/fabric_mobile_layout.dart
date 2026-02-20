import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/fabric/presentation/widgets/build_invoice_upload.dart';
import 'package:hi_class_factory/features/fabric/presentation/widgets/build_stock_list.dart';

import '../../data/models/stock_model.dart';
import '../widgets/tabs_widget.dart';

class FabricMobileLayout extends StatefulWidget {
  const FabricMobileLayout({super.key});

  @override
  State<FabricMobileLayout> createState() => _FabricMobileLayoutState();
}

class _FabricMobileLayoutState extends State<FabricMobileLayout> {
  int tab = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مخزن القماش"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTabFloatingActionButton(tab);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Tabs
          TabsWidget(
            onTap: (int selectedTab) {
              setState(() {
                tab = selectedTab;
              });
            },
          ),
          const SizedBox(height: 10),
          if (tab == 0) Expanded(child: BuildInvoiceUpload()),
          if (tab == 1) Expanded(child: BuildStockList()),
        ],
      ),
    );
  }

  void _onTabFloatingActionButton(int tabNumber) async {
    if (tabNumber == 0) {
    } else if (tabNumber == 1) {
      final result = await showModalBottomSheet<StockModel>(
        context: context,
        isScrollControlled: true,
        builder: (_) => Column(),
        // builder: (_) => const AddAccessoriesBottomSheet(),
      );
      if (!mounted) return;
      if (result != null) {
        // context.read<AccessoriesCubit>().addAccessories(result);
      }
    }
  }
}
