import 'package:flutter/material.dart';

import 'screen_breakpoints.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobilLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });
  final WidgetBuilder mobilLayout, tabletLayout, desktopLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        if (maxWidth < ScreenBreakpoints.tablet) {
          return mobilLayout(context);
        } else if (maxWidth < ScreenBreakpoints.desktop) {
          return tabletLayout(context);
        } else {
          return desktopLayout(context);
        }
      },
    );
  }
}
