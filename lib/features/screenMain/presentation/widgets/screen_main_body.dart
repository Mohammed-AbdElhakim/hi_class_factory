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
    case AppStrings.dashboard:
      return Center(child: Text("dashboard"));
    case AppStrings.finalProductStore:
      return FinalProductStoreView();
    case "/finished-store":
      return Center(child: Text("finished-store"));
    case "/store-movement":
      return Center(child: Text("store-movement"));
    case "/store-movement2":
      return Center(child: Text("store-movement2"));
    default:
      return Center(child: Text("data"));
  }
}
