import 'package:flutter/material.dart';

import '../../data/models/drawer_item_model.dart';
import '../../data/models/user_info_model.dart';
import 'drawer_items_list_view.dart';
import 'selected_and_not_selected_drawer_item.dart';
import 'user_info.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width < 800
          ? MediaQuery.sizeOf(context).width * .75
          : null,
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xffC4C4C4),
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Icon(Icons.eighteen_mp),
            ),
          ),
          SliverToBoxAdapter(
            child: UserInfo(
              userInfoModel: UserInfoModel(
                name: "Lekan Okeowo",
                email: "demo@gmail.com",
                image: "AppAssets.imagesAvatar3",
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const DrawerItemsListView(),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Spacer(),
                SizedBox(height: 20),
                NotSelectedDrawerItem(
                  drawerItemModel: DrawerItemModel(
                    image: "AppAssets.imagesSettings",
                    title: "Setting system",
                  ),
                ),
                SizedBox(height: 20),
                NotSelectedDrawerItem(
                  drawerItemModel: DrawerItemModel(
                    image: "AppAssets.imagesLogout",
                    title: "Logout account",
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
