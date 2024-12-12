import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/app/error_widget_main.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/di/dependency_injection.dart';
import 'package:curai_app_mobile/core/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/logger_helper.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setCustomErrorWidget();
  Bloc.observer = SimpleBlocObserver();
  dependencyInjectionSetup();
  hideKeyboard();

  try {
    await initializeDependencies();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    runApp(MyApp(environment: sl<EnvVariables>().debugMode));
    FlutterNativeSplash.remove();
  } catch (e, stackTrace) {
    LoggerHelper.error(
      'Dependency initialization failed',
      stackTrace: stackTrace,
      error: e,
      tag: 'Initialization main',
    );
  }
}

void setCustomErrorWidget() {
  ErrorWidget.builder =
      (FlutterErrorDetails details) => const ErrorWidgetMain();
}

Future<void> initializeDependencies() async {
  await Future.wait([
    sl<ConnectivityController>().connectivityControllerInit(),
    sl<SharedPrefManager>().sharedPreferencesInitialize(),
    sl<EnvVariables>().envVariablesSetup(envType: EnvTypeEnum.dev),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  if (kReleaseMode) {
    await Future.delayed(const Duration(seconds: 1));
  }
}
