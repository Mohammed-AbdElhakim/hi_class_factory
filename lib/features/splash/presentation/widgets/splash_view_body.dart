import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_class_factory/core/constants/app_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> sliderAnimation;

  @override
  void initState() {
    super.initState();
    initSlidAnimation();
    navigateToNewView();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: AnimatedBuilder(
        animation: sliderAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: sliderAnimation,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Image.asset(
                //   AppAssets.logo,
                //   height: 170,
                //   width: 170,
                // ),
                Text(
                  "Hi Class Factory",
                  textAlign: TextAlign.center,
                  style: AppStyles.styleBold20(
                    context,
                  ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void navigateToNewView() {
    Future.delayed(const Duration(seconds: 3), () async {
      // await Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
      bool isLogin = await Pref.getBoolFromPref(key: AppStrings.isLoginKey) ?? false;

      if (isLogin == true) {
        if (!mounted) return;
        GoRouter.of(context).pushReplacement(AppRouter.kScreenMainView);
        // AppRouter.pushReplacement(AppRouter.kHomeView);
      } else if (isLogin == false) {
        // GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        if (!mounted) return;
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        // AppRouter.pushReplacement(AppRouter.kLoginView);
      }
    });
  }

  void initSlidAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    sliderAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }
}
