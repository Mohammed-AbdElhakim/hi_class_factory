import 'package:flutter/material.dart';
import 'package:hi_class_factory/features/auth/presentation/layouts/desktop/login_desktop_layout.dart';

import '../../../../core/responsive/adaptive_layout.dart';
import '../layouts/mobile/login_mobile_layout.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: AdaptiveLayout(
                mobilLayout: (context) => LoginMobileLayout(),
                desktopLayout: (context) => LoginDeskTopLayout(),
                tabletLayout: (context) => LoginMobileLayout(),
              ),
            ),
          );
        },
      ),
    );
  }
}
