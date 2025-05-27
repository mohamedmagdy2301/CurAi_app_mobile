import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/app/initialize_services.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeServices.initializeServices();

  if (sl<AppEnvironment>().debugMode) {
    runApp(const MyApp());
  } else {
    await SentryFlutter.init(
      appRunner: () => runApp(SentryWidget(child: const MyApp())),
      (options) => options
        ..dsn = sl<AppEnvironment>().dsnSentry
        ..environment = AppConstants.kProduction,
    );
  }
}
