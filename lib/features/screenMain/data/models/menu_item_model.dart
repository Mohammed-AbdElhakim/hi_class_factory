import 'package:flutter/material.dart';

enum UserRole { admin, manager, worker }

class MenuItemModel {
  final String title;
  final IconData icon;
  final String route;
  final List<UserRole> roles;
  final List<MenuItemModel>? children;

  MenuItemModel({
    required this.title,
    required this.icon,
    required this.route,
    required this.roles,
    this.children,
  });
}
