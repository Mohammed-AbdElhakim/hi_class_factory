import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/theme/theme_cubit/theme_cubit.dart';
import 'core/theme/theme_service.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        return ThemeCubit(ThemeService());
      },
      child: MyApp(),
    ),
  );
}
