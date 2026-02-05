import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_service.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeService _themeService;

  ThemeCubit(this._themeService) : super(ThemeState(ThemeMode.light)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _themeService.loadTheme();
    emit(ThemeState(savedTheme));
  }

  Future<void> toggleTheme() async {
    final newTheme =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    await _themeService.saveTheme(newTheme);
    emit(ThemeState(newTheme));
  }
}
