import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_colors.dart';
import 'package:hi_class_factory/core/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../generated/l10n.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(S.of(context).username, style: AppStyles.fieldLabel),
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          hint: S.of(context).username,
          hintStyle: AppStyles.fieldLabel,
          keyboardType: TextInputType.text,
          fillColor: AppColors.darkCard,
          // borderColor: AppColors.borderColor,
          borderRadius: 8,
          controller: emailController,
          validator: (value) => value.validateField(context),
        ),
        SizedBox(height: 16),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(S.of(context).password, style: AppStyles.fieldLabel),
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          hint: S.of(context).password,
          hintStyle: AppStyles.fieldLabel,
          // borderColor: AppColors.borderColor,
          controller: passwordController,
          fillColor: AppColors.darkCard,
          borderRadius: 8,
          obscureText: true,
          showPasswordToggle: true,
          prefixIcon: Icons.lock,
          validator: (value) => value.validatePassword(context),
        ),
        SizedBox(height: 25),
        // TextField(
        //   controller: emailController,
        //   decoration: const InputDecoration(labelText: "Email"),
        // ),
        // const SizedBox(height: 20),
        // TextField(
        //   controller: passwordController,
        //   obscureText: true,
        //   decoration: const InputDecoration(
        //     labelText: "Password",
        //     suffixIcon: Icon(Icons.visibility_off),
        //   ),
        // ),
      ],
    );
  }
}
