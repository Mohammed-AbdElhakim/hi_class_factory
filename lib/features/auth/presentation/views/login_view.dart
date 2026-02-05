import 'package:flutter/material.dart';

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
                desktopLayout: (context) => LoginMobileLayout(),
                tabletLayout: (context) => LoginMobileLayout(),
              ),
            ),
          );
        },
      ),
    );
  }
}
