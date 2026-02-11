import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_styles.dart';
import 'package:hi_class_factory/features/screenMain/presentation/views/screen_main_view.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_navigator_x_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../manager/loginCubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMassage)));
        }

        if (state is LoginSuccess) {
          context.pushReplacementPage(page: ScreenMainView());
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  S.of(context).username,
                  style: AppStyles.styleRegular14(context).copyWith(fontSize: 12),
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hint: S.of(context).username,
                hintStyle: AppStyles.styleRegular14(
                  context,
                ).copyWith(fontSize: 12, color: theme.secondary),
                keyboardType: TextInputType.text,
                fillColor: theme.surface,
                borderColor: AppColors.borderColor,
                borderRadius: 8,
                controller: _userNameController,
                validator: (value) => value.validateField(context),
              ),
              SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  S.of(context).password,
                  style: AppStyles.styleRegular14(context).copyWith(fontSize: 12),
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                hint: S.of(context).password,
                hintStyle: AppStyles.styleRegular14(
                  context,
                ).copyWith(fontSize: 12, color: theme.secondary),
                borderColor: AppColors.borderColor,
                controller: _passwordController,
                fillColor: theme.surface,
                borderRadius: 8,
                obscureText: true,
                showPasswordToggle: true,
                validator: (value) => value.validatePassword(context),
              ),
              SizedBox(height: 25),
              CustomButton(
                text: S.of(context).login,
                // textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final userName = _userNameController.text.trim();
                    final password = _passwordController.text.trim();
                    // context.read<ThemeCubit>().toggleTheme();
                    context.read<LoginCubit>().loginUser(
                      username: userName,
                      password: password,
                      context: context,
                    );
                  }
                },
                width: double.infinity,
                backgroundColor: theme.primary,
                loading: state is LoginLoading ? true : false,
                disabled: state is LoginLoading ? true : false,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
