import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_class_factory/core/constants/app_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
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
      decoration: BoxDecoration(
        color: Color(0xFFF9F6F7),
        // color: Theme.of(context).colorScheme.primary
      ),
      child: AnimatedBuilder(
        animation: sliderAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: sliderAnimation,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryRed.withValues(alpha: 0.3),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Image.asset(AppAssets.logoImg, height: 120, width: 120),
                ),

                Positioned(
                  bottom: -50,
                  child: Text(
                    "Management System",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: -70,
                  child: Text(
                    "Garment Factory Portal",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void navigateToNewView() {
    Future.delayed(const Duration(seconds: 4), () async {
      // await Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
      bool isLogin = await Pref.getBoolFromPref(key: AppStrings.isLoginKey) ?? false;

      if (isLogin == true) {
        if (!mounted) return;
        GoRouter.of(context).pushReplacement(AppRouter.kNavigationBarView);
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
