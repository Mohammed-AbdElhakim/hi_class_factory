import 'package:flutter/material.dart';

import '../../../data/models/menu_item_model.dart';
import '../../widgets/app_menu.dart';

class ScreenMainDesktopLayout extends StatelessWidget {
  const ScreenMainDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppMenu(
            role: UserRole.admin,
            onTap: (route) {
              print(route);
            },
          ),
          Expanded(child: const Center(child: Text('Content'))),
        ],
      ),
    );
  }
}
