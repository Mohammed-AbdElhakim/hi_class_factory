import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/widgets/custom_text_form_field.dart';
import 'package:hi_class_factory/features/finalProductStore/presentation/widgets/custom_list_item.dart';

import '../../../data/models/product_detail_model.dart';

class FinalProductStoreMobileLayout extends StatelessWidget {
  const FinalProductStoreMobileLayout({super.key, required this.pageName});
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(height: 55, child: CustomTextFormField(hint: "بحث")),
            const SizedBox(height: 17),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CustomListItem(
                details: [
                  ProductDetailModel(size: "S", colors: [Colors.red, Colors.black]),
                  ProductDetailModel(
                    size: "M",
                    colors: [Colors.blue, Colors.purple, Colors.green],
                  ),
                  ProductDetailModel(size: "L", colors: [Colors.cyanAccent]),
                  ProductDetailModel(size: "XL", colors: [Colors.orange]),
                  ProductDetailModel(
                    size: "4XL",
                    colors: [
                      Colors.orange,
                      Colors.red,
                      Colors.black,
                      Colors.cyanAccent,
                      Colors.blue,
                      Colors.purple,
                      Colors.green,
                      Colors.orange,
                      Colors.red,
                      Colors.black,
                      Colors.cyanAccent,
                      Colors.blue,
                      Colors.purple,
                      Colors.green,
                    ],
                  ),
                ],
              ),
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
