import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

extension StringExtension on String? {
  String? validateField(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return S.of(context).required_field;
    }

    return null;
  }

  String? validateEmail(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return S.of(context).required_field;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(this!)) {
      return S.of(context).email_incorrect;
    }

    return null;
  }

  String? validatePassword(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return S.of(context).required_field;
    }
    if (this!.length < 6) {
      return S.of(context).least_characters;
    }
    return null;
  }
}
