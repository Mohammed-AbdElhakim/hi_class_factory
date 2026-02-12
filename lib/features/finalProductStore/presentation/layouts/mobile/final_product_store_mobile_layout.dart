import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';
import 'package:hi_class_factory/core/widgets/custom_text_form_field.dart';

class FinalProductStoreMobileLayout extends StatefulWidget {
  const FinalProductStoreMobileLayout({super.key, required this.pageName});
  final String pageName;

  @override
  State<FinalProductStoreMobileLayout> createState() =>
      _FinalProductStoreMobileLayoutState();
}

class _FinalProductStoreMobileLayoutState extends State<FinalProductStoreMobileLayout> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(height: 35, child: CustomTextFormField(hint: "بحث")),
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() {
                showDetails = !showDetails;
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("اسم المنتج"),
                  subtitle: Text("وصف المنتج"),
                  trailing: Text("1225"),
                  leading: Image.asset(AppAssets.logoImg),
                ),
              ),
            ),
          ),
          if (showDetails) Column(children: [Text("التفاصيل")]),
        ],
      ),
    );
  }
}
