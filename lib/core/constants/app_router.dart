import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  // GoRouter configuration
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String kSplashView = "/";
  static const String kLoginView = "/loginView";
  static const String kScreenMainView = "/screenMainView";
  // static const String kHomeView = "/homeView";

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: kSplashView,
    routes: [
      GoRoute(path: kSplashView, builder: (context, state) => const SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      // GoRoute(path: kScreenMainView, builder: (context, state) => const ScreenMainView()),
      // GoRoute(path: kHomeView, builder: (context, state) => const MyHomePage()),
    ],
  );

  // ✅ Helper method عشان تستخدمه من أى مكان
  static void pushReplacement(String route, {Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).pushReplacement(route, extra: extra);
    }
  }

  static void push(String route, {Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).push(route, extra: extra);
    }
  }
}
