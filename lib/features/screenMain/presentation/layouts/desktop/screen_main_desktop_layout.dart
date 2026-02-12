import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_strings.dart';

import '../../../data/models/menu_item_model.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/screen_main_body.dart';

class ScreenMainDesktopLayout extends StatefulWidget {
  const ScreenMainDesktopLayout({super.key});

  @override
  State<ScreenMainDesktopLayout> createState() => _ScreenMainDesktopLayoutState();
}

class _ScreenMainDesktopLayoutState extends State<ScreenMainDesktopLayout> {
  String myRoute = AppStrings.dashboard;
  String myPageName = AppStrings.dashboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppMenu(
            role: UserRole.admin,
            onTap: (route, pageName) {
              setState(() {
                myRoute = route;
                myPageName = pageName;
              });
            },
          ),
          Expanded(child: ScreenMainBody(route: myRoute)),
        ],
      ),
    );
  }
}
