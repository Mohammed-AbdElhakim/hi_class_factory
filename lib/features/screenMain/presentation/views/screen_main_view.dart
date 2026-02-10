import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';
import 'package:hi_class_factory/core/responsive/screen_breakpoints.dart';
import 'package:hi_class_factory/features/screenMain/presentation/layouts/desktop/screen_main_desktop_layout.dart';
import 'package:hi_class_factory/features/screenMain/presentation/layouts/mobile/screen_main_mobile_layout.dart';

class ScreenMainView extends StatefulWidget {
  const ScreenMainView({super.key});

  @override
  State<ScreenMainView> createState() => _ScreenMainViewState();
}

class _ScreenMainViewState extends State<ScreenMainView> {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ScreenBreakpoints.init(context);
    return AdaptiveLayout(
      mobilLayout: (context) => ScreenMainMobileLayout(),
      tabletLayout: (context) => ScreenMainDesktopLayout(),
      desktopLayout: (context) => ScreenMainDesktopLayout(),
    );
  }
}
