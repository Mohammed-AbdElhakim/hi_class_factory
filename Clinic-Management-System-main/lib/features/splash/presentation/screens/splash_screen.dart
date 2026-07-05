import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    // Using direct constructor injection or GetIt since we aren't instantiating BlocProvider yet
    _splashBloc = SplashBloc();
    _splashBloc.add(const SplashEvent.initialize());
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        state.whenOrNull(
          navToOnboarding: () => context.go(AppRouter.onboarding),
          navToAuth: () => context.go(AppRouter.login),
          navToHome: () => context.go(AppRouter.home),
        );
      },
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 80,
              ),
              SizedBox(height: 16),
              Text(
                'WIMM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 8),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
