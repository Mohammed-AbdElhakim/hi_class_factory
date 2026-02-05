import 'package:flutter/material.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../widgets/login_form.dart';

class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 24, top: 48),
      child: Column(
        children: [
          SizedBox(height: 25),
          Text(
            S.of(context).welcome_back,
            style: AppStyles.styleBold24(context).copyWith(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Text(
              S.of(context).welcome_back_info,
              style: AppStyles.styleBold20(context),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          LoginForm(),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
