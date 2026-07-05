import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  late final OnboardingBloc _onboardingBloc;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _onboardingBloc = OnboardingBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _onboardingBloc.close();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onNextPressed() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _onboardingBloc.add(const OnboardingEvent.complete());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      bloc: _onboardingBloc,
      listener: (context, state) {
        state.whenOrNull(
          completed: () => context.go(AppRouter.login),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => _onboardingBloc.add(const OnboardingEvent.complete()),
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: const [
                      OnboardingPage(
                        title: 'Track Expenses',
                        description: 'Log and organize all your daily spending in one smart place.',
                        icon: Icons.account_balance_wallet_rounded,
                      ),
                      OnboardingPage(
                        title: 'Set Budgets',
                        description: 'Define limits for categories and manage your capital easily.',
                        icon: Icons.pie_chart_rounded,
                      ),
                      OnboardingPage(
                        title: 'Visualize Progress',
                        description: 'See detailed monthly reports and visual charts of your growth.',
                        icon: Icons.trending_up_rounded,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppColors.primary : AppColors.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: _currentPage == 2 ? 'Get Started' : 'Next',
                  onPressed: _onNextPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
