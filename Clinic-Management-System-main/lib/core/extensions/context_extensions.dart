import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  String translate(String key, {List<String>? args, Map<String, String>? namedArgs, String? gender}) =>
      key.tr(args: args, namedArgs: namedArgs, gender: gender);
}
