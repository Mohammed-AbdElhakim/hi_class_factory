import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../finishedProducts/data/models/product_model.dart';
import '../../../finishedProducts/data/models/size_model.dart';
import 'size_item.dart';

class BuildInvoicesBody extends StatefulWidget {
  const BuildInvoicesBody({super.key, required this.productsList});
  final List<ProductModel> productsList;

  @override
  State<BuildInvoicesBody> createState() => _BuildInvoicesBodyState();
}

class _BuildInvoicesBodyState extends State<BuildInvoicesBody> {
  ProductModel? productSelected;
  List<SizeModel>? sizeList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: CustomDropdown<ProductModel>.search(
                    hintText: 'اختر منتج',
                    initialItem: productSelected,
                    items: widget.productsList,
                    excludeSelected: false,
                    onChanged: (product) {
                      setState(() {
                        productSelected = product;
                        sizeList = product?.sizes;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      productSelected = null;
                      sizeList = null;
                    });
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
          if (productSelected != null)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final itemSize = sizeList![index];
                return SizeItem(
                  itemSize: itemSize,
                  onTap: (selectItem) {
                    // print(
                    //   "===============\n${selectedItems[index]?.color}====${selectedItems[index]?.size}\n===================",
                    // );
                  },
                );
              }, childCount: sizeList!.length),
            ),
        ],
      ),
    );
  }
}
