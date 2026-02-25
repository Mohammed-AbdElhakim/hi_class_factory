import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/constants/service_locator.dart';
import 'core/theme/theme_cubit/theme_cubit.dart';
import 'core/theme/theme_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  runApp(
    BlocProvider(
      create: (context) {
        return ThemeCubit(ThemeService());
      },
      child: MyApp(),
    ),
  );
}
