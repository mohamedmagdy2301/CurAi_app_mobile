import 'dart:developer';

import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/app/error_widget_main.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/di/dependency_injection.dart';
import 'package:curai_app_mobile/core/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const ErrorWidgetMain();
  };
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  dependencyInjectionSetup(); // Initialize dependencies
  hideKeyboard();
  try {
    await Future.wait([
      sl<ConnectivityController>().connectivityControllerInit(),
      sl<SharedPrefManager>().sharedPreferencesInitialize(),
      sl<EnvVariables>().envVariablesSetup(envType: EnvTypeEnum.dev),
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    ]);
    runApp(
      MyApp(
        environment: sl<EnvVariables>().debugMode,
      ),
    );
  } catch (e, stackTrace) {
    log('Initialization failed: $e\n$stackTrace');
  }
}
