import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndexPage,
    required this.onTap,
  });

  final int currentIndexPage;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.dashboard, S.of(context).home),
      (Icons.list_alt, S.of(context).reports),
      (Icons.groups, S.of(context).employees),
      (Icons.settings, S.of(context).settings),
    ];
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 16, bottom: 18, start: 16, end: 16),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: currentIndexPage,
          onTap: onTap,
          backgroundColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          // selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.onPrimary.withValues(alpha: .5),
          // unselectedItemColor: Colors.white54,
          items: items
              .map((e) => BottomNavigationBarItem(icon: Icon(e.$1), label: e.$2))
              .toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) => BottomNavigationBarItem(icon: Icon(icon), label: label);
}
