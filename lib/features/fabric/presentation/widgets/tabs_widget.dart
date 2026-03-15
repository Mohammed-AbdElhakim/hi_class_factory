import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'tab_item.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key, required this.onTap});
  final void Function(int selectedTab) onTap;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int selectedTab = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabItem(
          title: S.of(context).uploadIncomingInvoice,
          isSelected: selectedTab == 0,
          onTap: () {
            setState(() {
              selectedTab = 0;
            });
            widget.onTap(0);
          },
        ),
        TabItem(
          title: S.of(context).availableInStock,
          isSelected: selectedTab == 1,
          onTap: () {
            setState(() {
              selectedTab = 1;
            });
            widget.onTap(1);
          },
        ),
      ],
    );
  }
}
