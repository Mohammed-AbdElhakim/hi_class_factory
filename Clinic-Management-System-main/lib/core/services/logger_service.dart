import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class LoggerService {
  void debug(String message, [dynamic error, StackTrace? stackTrace]);
  void info(String message);
  void warning(String message, [dynamic error, StackTrace? stackTrace]);
  void error(String message, [dynamic error, StackTrace? stackTrace]);
}

@LazySingleton(as: LoggerService)
class LoggerServiceImpl implements LoggerService {
  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[DEBUG] $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print(stackTrace);
    }
  }

  @override
  void info(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[WARNING] $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print(stackTrace);
    }
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message');
    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint(stackTrace.toString());
  }
}
