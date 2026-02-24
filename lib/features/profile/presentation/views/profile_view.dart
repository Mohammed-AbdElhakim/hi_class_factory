import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi_class_factory/core/constants/service_locator.dart';
import 'package:hi_class_factory/core/responsive/adaptive_layout.dart';

import '../../data/repositories/profile_repo_impl.dart';
import '../layouts/mobile/profile_mobile_layout.dart';
import '../manager/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt.get<ProfileRepoImpl>())..getProfile(),
      child: AdaptiveLayout(
        mobilLayout: (context) => ProfileMobileLayout(),
        tabletLayout: (context) => ProfileMobileLayout(),
        desktopLayout: (context) => ProfileMobileLayout(),
      ),
    );
  }
}
