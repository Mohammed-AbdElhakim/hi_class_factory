import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_colors.dart';
import 'package:hi_class_factory/core/widgets/custom_button.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../manager/loginCubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        }
        return CustomButton(
          text: S.of(context).login,
          backgroundColor: AppColors.primaryRed,
          style: ButtonMyStyle.primary,
          iconAfterText: true,
          icon: Icons.arrow_forward,
          width: double.infinity,
          onPressed: () {
            context.read<LoginCubit>().loginUser(
              context: context,
              username: emailController.text,
              password: passwordController.text,
            );
          },
        );
      },
    );
  }
}
