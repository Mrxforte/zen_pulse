import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zen_pulse/app/zen_pulse_app.dart';
import 'package:zen_pulse/core/di/service_locator.dart';
import 'package:zen_pulse/core/logging/app_logger.dart';

Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupServiceLocator();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    AppLogger.error(
      details.exception,
      details.stack ?? StackTrace.current,
      context: 'Flutter framework error',
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error(error, stack, context: 'Uncaught zone error');
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    );
    return true;
  };

  runApp(const ZenPulseApp());
}
