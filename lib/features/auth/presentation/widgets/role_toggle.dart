import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/app_colors.dart';
import 'package:hi_class_factory/core/widgets/custom_button.dart';
import 'package:hi_class_factory/generated/l10n.dart';

import '../manager/loginCubit/login_cubit.dart';

class RoleToggle extends StatefulWidget {
  const RoleToggle({super.key});

  @override
  State<RoleToggle> createState() => _RoleToggleState();
}

class _RoleToggleState extends State<RoleToggle> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isEmployee = cubit.isEmployee;

        return Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.darkCard,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: isEmployee ? AppColors.primaryRed : AppColors.darkCard,
                  text: S.of(context).employee,
                  onPressed: () {
                    cubit.toggleRole(true);
                    setState(() {});
                  },
                  style: ButtonMyStyle.primary,
                ),
              ),
              Expanded(
                child: CustomButton(
                  backgroundColor: isEmployee ? AppColors.darkCard : AppColors.primaryRed,
                  text: S.of(context).admin,
                  onPressed: () {
                    cubit.toggleRole(false);
                    setState(() {});
                  },
                  style: ButtonMyStyle.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
