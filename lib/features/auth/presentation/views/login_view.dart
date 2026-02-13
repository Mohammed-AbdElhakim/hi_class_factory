import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/service_locator.dart';
import 'package:hi_class_factory/features/auth/presentation/layouts/desktop/login_desktop_layout.dart';

import '../../../../core/responsive/adaptive_layout.dart';
import '../../data/repositories/login_repo_impl.dart';
import '../layouts/mobile/login_mobile_layout.dart';
import '../manager/loginCubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<LoginRepoImpl>()),
      child: Scaffold(
        body: AdaptiveLayout(
          mobilLayout: (context) => LoginMobileLayout(),
          desktopLayout: (context) => LoginDeskTopLayout(),
          tabletLayout: (context) => LoginDeskTopLayout(),
        ),
      ),
    );
  }
}
