import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../widgets/login_form.dart';

class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(child: LoginForm()),
        ),
      ),
    );
  }
}
