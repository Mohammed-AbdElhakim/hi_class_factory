import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../finalProductStore/presentation/views/final_product_store_view.dart';

class ScreenMainBody extends StatelessWidget {
  const ScreenMainBody({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return myWidget(route);
  }
}

Widget myWidget(String m) {
  switch (m) {
    // الداش بورد
    case AppStrings.dashboard:
      return Center(child: Text("dashboard"));
    // مخزن المنتج النهائى
    case AppStrings.finalProductStore:
      return FinalProductStoreView();
      // مخزن البكر
    case "/finished-store":
      return Center(child: Text("finished-store"));
      // مخزن القماش
    case "/store-movement":
      return Center(child: Text("store-movement"));
      //  مخزن الاكسسوارات
    case "/store-movement2":
      return Center(child: Text("store-movement2"));
      // الاعدادات
    default:
      return Center(child: Text("data"));
  }
}
