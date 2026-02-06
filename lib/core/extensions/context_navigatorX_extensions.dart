import 'package:flutter/material.dart';

extension NavigatorX on BuildContext {
  /// Push Page
  Future<T?> pushPage<T>({required Widget page}) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// Push Replacement
  Future<T?> pushReplacementPage<T, TO>({required Widget page}) {
    return Navigator.of(
      this,
    ).pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  /// Push and remove all previous
  Future<T?> pushAndRemoveUntilPage<T>({required Widget page}) {
    return Navigator.of(
      this,
    ).pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  /// Pop current page
  void popPage<T>({T? result}) {
    Navigator.of(this).pop<T>(result);
  }
}
