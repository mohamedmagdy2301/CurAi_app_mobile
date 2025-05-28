import 'dart:developer';

import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/app/initialize_services.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add error handling for service initialization
  try {
    await InitializeServices.initializeServices();
  } on Exception catch (e) {
    log('Error initializing services: $e');
    // Consider showing an error screen or retrying initialization
  }

  if (sl<AppEnvironment>().debugMode) {
    // Use a slight delay to ensure proper initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        runApp(const MyApp());
      });
    });
  } else {
    await SentryFlutter.init(
      appRunner: () => runApp(SentryWidget(child: const MyApp())),
      (options) => options
        ..dsn = sl<AppEnvironment>().dsnSentry
        ..environment = AppConstants.kProduction,
    );
  }
}
