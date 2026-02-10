import 'package:flutter/material.dart';

import '../../data/models/drawer_item_model.dart';
import 'selected_and_not_selected_drawer_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.drawerItemModel, required this.isSelected});
  final DrawerItemModel drawerItemModel;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? SelectedDrawerItem(drawerItemModel: drawerItemModel)
        : NotSelectedDrawerItem(drawerItemModel: drawerItemModel);
  }
}
