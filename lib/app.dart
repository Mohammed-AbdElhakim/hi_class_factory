import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'MyHomePage.dart';
import 'core/constants/app_strings.dart';
import 'core/helper/SharedPreferences/pref.dart';
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
  Locale _locale = const Locale(AppStrings.enLangKey);
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hi Class Factory',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: _locale,
      home: MyHomePage(),
    );
  }

  Future<void> getLocale() async {
    String language =
        await Pref.getStringFromPref(key: AppStrings.langKey) ?? AppStrings.enLangKey;
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
