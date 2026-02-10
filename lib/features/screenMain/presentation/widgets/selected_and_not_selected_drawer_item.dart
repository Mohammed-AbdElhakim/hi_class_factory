import 'package:flutter/material.dart';

import '../../../../core/constants/app_styles.dart';
import '../../data/models/drawer_item_model.dart';

class SelectedDrawerItem extends StatelessWidget {
  const SelectedDrawerItem({super.key, required this.drawerItemModel});

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Text(drawerItemModel.title, style: AppStyles.styleBold16(context)),
      ),
      leading: Icon(Icons.edit),
      trailing: Container(width: 3.5, color: const Color(0xFF4EB7F2)),
    );
  }
}

class NotSelectedDrawerItem extends StatelessWidget {
  const NotSelectedDrawerItem({super.key, required this.drawerItemModel});

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Text(drawerItemModel.title, style: AppStyles.styleRegular16(context)),
      ),
      leading: Icon(Icons.edit_note),
    );
  }
}
