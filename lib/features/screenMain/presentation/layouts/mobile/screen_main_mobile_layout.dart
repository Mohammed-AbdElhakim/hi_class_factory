import 'package:flutter/material.dart';

import '../../../data/models/menu_item_model.dart';
import '../../widgets/app_menu.dart';

class ScreenMainMobileLayout extends StatelessWidget {
  const ScreenMainMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Factory System')),
      drawer: AppMenu(role: UserRole.admin),
      body: const Center(child: Text('Mobile')),
    );
  }
}
