// ignore_for_file: depend_on_referenced_packages

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/app/error_widget_main.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/utils/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setCustomErrorWidget();
  CacheDataHelper.sharedPreferencesInitialize();
  Bloc.observer = SimpleBlocObserver();
  setupInit();
  Gemini.init(apiKey: 'AIzaSyA_ehqc-SrrKJDn5jO77Fgy_ae00UvevaM');

  try {
    await initializeDependencies();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    final savedThemeMode =
        CacheDataHelper.getData(key: SharedPrefKey.saveThemeMode) ??
            AdaptiveThemeMode.system;
    final savedThemeColor = await CacheDataHelper.getData(
          key: SharedPrefKey.keyThemeColor,
        ) ??
        AppColors.primary;
    runApp(
      BlocProvider(
        create: (context) => LocalizationCubit(),
        child: MyApp(
          environment: sl<EnvVariables>().debugMode,
          savedThemeColor: savedThemeColor as Color,
          savedThemeMode: savedThemeMode as AdaptiveThemeMode,
        ),
      ),
    );
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
      (FlutterErrorDetails details) => ErrorWidgetMain(details: details);
}

Future<void> initializeDependencies() async {
  hideKeyboard();
  await Future.wait([
    sl<ConnectivityController>().connectivityControllerInit(),
    sl<SharedPrefManager>().sharedPreferencesInitialize(),
    sl<EnvVariables>().envVariablesSetup(envType: EnvTypeEnum.dev),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  if (kReleaseMode) {
    await Future.delayed(const Duration(seconds: 1), () {});
  }
}
