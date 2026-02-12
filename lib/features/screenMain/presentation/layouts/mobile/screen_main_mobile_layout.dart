import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../data/models/menu_item_model.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/screen_main_body.dart';

class ScreenMainMobileLayout extends StatefulWidget {
  const ScreenMainMobileLayout({super.key});

  @override
  State<ScreenMainMobileLayout> createState() => _ScreenMainMobileLayoutState();
}

class _ScreenMainMobileLayoutState extends State<ScreenMainMobileLayout> {
  String myRoute = AppStrings.dashboard;
  String myPageName = AppStrings.dashboard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(myPageName)),
      drawer: AppMenu(
        role: UserRole.admin,
        onTap: (route, pageName) {
          setState(() {
            myRoute = route;
            myPageName = pageName;
          });
          context.pop();
        },
      ),
      body: ScreenMainBody(route: myRoute),
    );
  }
}
