import 'package:flutter/foundation.dart';

class AppEnvironment {
  AppEnvironment._();

  static const String appFlavor = String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'production',
  );

  static bool get isRelease => kReleaseMode;

  static bool get enableVerboseLogs => !kReleaseMode;
}
