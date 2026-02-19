import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/service_locator.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../data/repositories/bakr_repo_impl.dart';
import '../layouts/mobile/bakr_mobile_layout.dart';
import '../manager/bakr_cubit.dart';

class BakrView extends StatefulWidget {
  const BakrView({super.key});

  @override
  State<BakrView> createState() => _BakrViewState();
}

class _BakrViewState extends State<BakrView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BakrCubit(getIt.get<BakrRepoImpl>())..getBakr(),
      child: AdaptiveLayout(
        mobilLayout: (context) => BakrMobileLayout(),
        tabletLayout: (context) => BakrMobileLayout(),
        desktopLayout: (context) => BakrMobileLayout(),
      ),
    );
  }
}
