import 'package:flutter/material.dart';

import '../../data/models/drawer_item_model.dart';
import 'drawer_item.dart';

class DrawerItemsListView extends StatefulWidget {
  const DrawerItemsListView({super.key});

  @override
  State<DrawerItemsListView> createState() => _DrawerItemsListViewState();
}

class _DrawerItemsListViewState extends State<DrawerItemsListView> {
  List<DrawerItemModel> drawerItemList = [
    const DrawerItemModel(title: "Dashboard", image: "AppAssets.imagesDashboard"),
    const DrawerItemModel(
      title: "My Transaction",
      image: "AppAssets.imagesMyInvestments",
    ),
    const DrawerItemModel(title: "Statistics", image: "AppAssets.imagesSettings"),
    const DrawerItemModel(
      title: "Wallet Account",
      image: "AppAssets.imagesWalletAccount",
    ),
    const DrawerItemModel(
      title: "My Investments",
      image: "AppAssets.imagesMyInvestments",
    ),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: drawerItemList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          if (selectedIndex != index) {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: DrawerItem(
            drawerItemModel: drawerItemList[index],
            isSelected: selectedIndex == index,
          ),
        ),
      ),
    );
  }
}
