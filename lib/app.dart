import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_router.dart';
import 'core/constants/app_strings.dart';
import 'core/helper/SharedPreferences/pref.dart';
import 'core/theme/theme_cubit/theme_cubit.dart';
import 'core/theme/theme_cubit/theme_state.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale(AppStrings.arLangKey);
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Hi Class Factory',
          // theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
          // themeMode: state.themeMode,
          // theme: AppThemes.lightTheme,
          // darkTheme: AppThemes.darkTheme,
          theme: ThemeData(
            // scaffoldBackgroundColor: AppColors.background,
            colorScheme: .fromSeed(seedColor: Colors.red),
            fontFamily: 'Poppins',
            useMaterial3: true,
            iconTheme: IconThemeData(color: Colors.grey),
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          routerConfig: AppRouter.router,
        );
      },
    );
  }

  Future<void> getLocale() async {
    String language =
        await Pref.getStringFromPref(key: AppStrings.langKey) ?? AppStrings.arLangKey;
    setState(() {
      _locale = Locale(language);
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}
