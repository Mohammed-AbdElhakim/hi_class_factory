import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';
import 'package:hi_class_factory/core/constants/app_styles.dart';

import '../../../../core/extensions/context_navigator_x_extensions.dart';
import '../../../navigationBar/presentation/views/navigation_bar_view.dart';
import '../manager/loginCubit/login_cubit.dart';
import 'login_button.dart';
import 'login_fields.dart';
import 'role_toggle.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMassage)));
        }
        if (state is LoginSuccess) {
          context.pushReplacementPage(page: NavigationBarView());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Success")));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.logoImg, width: 80, height: 80),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("Hi Class", style: AppStyles.title),
          ),
          const RoleToggle(),
          const SizedBox(height: 30),
          LoginFields(
            emailController: emailController,
            passwordController: passwordController,
          ),
          const SizedBox(height: 20),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}
