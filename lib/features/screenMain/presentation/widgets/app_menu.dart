import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/screenMain/data/models/user_info_model.dart';
import 'package:hi_class_factory/features/screenMain/presentation/widgets/user_info.dart';

import '../../data/models/menu_item_model.dart';

class AppMenu extends StatefulWidget {
  final UserRole role;

  const AppMenu({super.key, required this.role});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  final List<MenuItemModel> menuItems = [
    // Dashboard
    MenuItemModel(
      title: 'Dashboard',
      icon: Icons.dashboard,
      route: '/dashboard',
      roles: [UserRole.admin, UserRole.manager],
    ),

    // المنتجات
    MenuItemModel(
      title: 'المنتجات',
      icon: Icons.checkroom,
      route: '',
      roles: [UserRole.admin, UserRole.manager],
      children: [
        MenuItemModel(
          title: 'قائمة المنتجات',
          icon: Icons.list,
          route: '/products',
          roles: [UserRole.admin, UserRole.manager],
        ),
        MenuItemModel(
          title: 'المقاسات',
          icon: Icons.straighten,
          route: '/sizes',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'الألوان',
          icon: Icons.color_lens,
          route: '/colors',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'الموديلات',
          icon: Icons.style,
          route: '/models',
          roles: [UserRole.admin],
        ),
      ],
    ),

    // الخامات
    MenuItemModel(
      title: 'الخامات',
      icon: Icons.inventory,
      route: '',
      roles: [UserRole.admin],
      children: [
        MenuItemModel(
          title: 'الأقمشة',
          icon: Icons.layers,
          route: '/fabrics',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'الإكسسوارات',
          icon: Icons.extension,
          route: '/accessories',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'مخزون الخامات',
          icon: Icons.warehouse,
          route: '/raw-stock',
          roles: [UserRole.admin],
        ),
      ],
    ),

    // التشغيل
    MenuItemModel(
      title: 'التشغيل',
      icon: Icons.factory,
      route: '',
      roles: [UserRole.admin, UserRole.manager],
      children: [
        MenuItemModel(
          title: 'أوامر التشغيل',
          icon: Icons.assignment,
          route: '/production-orders',
          roles: [UserRole.admin, UserRole.manager],
        ),
        MenuItemModel(
          title: 'مراحل الإنتاج',
          icon: Icons.timeline,
          route: '/production-stages',
          roles: [UserRole.admin, UserRole.manager],
        ),
      ],
    ),

    // العمال
    MenuItemModel(
      title: 'العمال',
      icon: Icons.people,
      route: '',
      roles: [UserRole.admin, UserRole.manager],
      children: [
        MenuItemModel(
          title: 'بيانات العمال',
          icon: Icons.badge,
          route: '/workers',
          roles: [UserRole.admin, UserRole.manager],
        ),
        MenuItemModel(
          title: 'الحضور والانصراف',
          icon: Icons.access_time,
          route: '/attendance',
          roles: [UserRole.admin, UserRole.manager],
        ),
        MenuItemModel(
          title: 'إنتاجية العمال',
          icon: Icons.bar_chart,
          route: '/worker-productivity',
          roles: [UserRole.admin, UserRole.manager],
        ),
      ],
    ),

    // المخازن
    MenuItemModel(
      title: 'المخازن',
      icon: Icons.store,
      route: '',
      roles: [UserRole.admin],
      children: [
        MenuItemModel(
          title: 'مخزن خامات',
          icon: Icons.inventory_2,
          route: '/raw-store',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'مخزن إنتاج تام',
          icon: Icons.check_box,
          route: '/finished-store',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'حركة المخزن',
          icon: Icons.swap_horiz,
          route: '/store-movement',
          roles: [UserRole.admin],
        ),
      ],
    ),

    // الطلبيات
    MenuItemModel(
      title: 'الطلبيات',
      icon: Icons.receipt_long,
      route: '',
      roles: [UserRole.admin, UserRole.manager],
      children: [
        MenuItemModel(
          title: 'العملاء',
          icon: Icons.person,
          route: '/customers',
          roles: [UserRole.admin, UserRole.manager],
        ),
        MenuItemModel(
          title: 'الطلبيات',
          icon: Icons.shopping_cart,
          route: '/orders',
          roles: [UserRole.admin, UserRole.manager],
        ),
      ],
    ),

    // الحسابات
    MenuItemModel(
      title: 'الحسابات',
      icon: Icons.attach_money,
      route: '',
      roles: [UserRole.admin],
      children: [
        MenuItemModel(
          title: 'المصروفات',
          icon: Icons.money_off,
          route: '/expenses',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'الرواتب',
          icon: Icons.payments,
          route: '/salaries',
          roles: [UserRole.admin],
        ),
        MenuItemModel(
          title: 'التقارير المالية',
          icon: Icons.pie_chart,
          route: '/finance-reports',
          roles: [UserRole.admin],
        ),
      ],
    ),

    // المستخدمين
    MenuItemModel(
      title: 'المستخدمين',
      icon: Icons.admin_panel_settings,
      route: '/users',
      roles: [UserRole.admin],
    ),

    // الإعدادات
    MenuItemModel(
      title: 'الإعدادات',
      icon: Icons.settings,
      route: '/settings',
      roles: [UserRole.admin],
    ),

    // Logout
    MenuItemModel(
      title: 'تسجيل الخروج',
      icon: Icons.logout,
      route: '/logout',
      roles: [UserRole.admin, UserRole.manager, UserRole.worker],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width >= 900;

    return isWeb ? _buildSidebar(context) : Drawer(child: _buildMenuList(context));
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.grey.shade100,
      child: _buildMenuList(context),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        UserInfo(
          userInfoModel: UserInfoModel(name: "name", email: "email", image: "image"),
        ),
        Expanded(
          child: ListView(
            children: menuItems.where((item) => item.roles.contains(widget.role)).map((
              item,
            ) {
              if (item.children != null) {
                return ExpansionTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  children: item.children!
                      .where((c) => c.roles.contains(widget.role))
                      .map(
                        (child) => ListTile(
                          leading: Icon(child.icon, size: 20),
                          title: Text(child.title),
                          onTap: () {
                            Navigator.pushNamed(context, child.route);
                          },
                        ),
                      )
                      .toList(),
                );
              }

              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                onTap: () {
                  Navigator.pushNamed(context, item.route);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
