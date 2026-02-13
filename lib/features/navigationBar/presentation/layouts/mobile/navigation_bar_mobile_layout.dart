import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/employee_view.dart';
import 'package:hi_class_factory/features/report_view.dart';
import 'package:hi_class_factory/features/sitting_view.dart';

import '../../../../home_view.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class NavigationBarMobileLayout extends StatefulWidget {
  const NavigationBarMobileLayout({super.key});

  @override
  State<NavigationBarMobileLayout> createState() => _NavigationBarMobileLayoutState();
}

class _NavigationBarMobileLayoutState extends State<NavigationBarMobileLayout> {
  int currentIndexPage = 0;

  final List<Widget> _pages = [HomeView(), ReportView(), EmployeeView(), SittingView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndexPage],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndexPage: currentIndexPage,
        onTap: (value) {
          setState(() {
            currentIndexPage = value;
          });
        },
      ),
    );
  }
}
