import 'package:flutter/material.dart';
import 'package:hi_class_factory/core/constants/app_assets.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../widgets/login_form.dart';

class LoginDeskTopLayout extends StatelessWidget {
  const LoginDeskTopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SizedBox(
      width: screen.width,
      height: screen.height,
      child: Row(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: Image.asset(AppAssets.loginImg, fit: BoxFit.fill),
            ),
          ),
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              S.of(context).welcome_back,
                              style: AppStyles.styleBold24(
                                context,
                              ).copyWith(fontSize: 30),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
