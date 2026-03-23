import 'dart:developer' as developer;

import 'package:zen_pulse/core/config/app_environment.dart';

class AppLogger {
  AppLogger._();

  static void info(String message) {
    if (AppEnvironment.enableVerboseLogs) {
      developer.log(message, name: 'ZenPulse');
    }
  }

  static void error(Object error, StackTrace stackTrace, {String? context}) {
    developer.log(
      context == null ? error.toString() : '$context: $error',
      name: 'ZenPulse',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
