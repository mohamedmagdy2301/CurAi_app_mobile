// ignore_for_file: depend_on_referenced_packages

import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/app/error_widget_main.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/utils/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  try {
    await initializeDependencies();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    runApp(
      BlocProvider(
        create: (context) => LocalizationCubit()..loadSettings(),
        child: MyApp(
          environment: sl<EnvVariables>().debugMode,
        ),
      ),
    );
    FlutterNativeSplash.remove();
  } on Exception catch (e, stackTrace) {
    if (kDebugMode) {
      LoggerHelper.error(
        'Dependency initialization failed',
        stackTrace: stackTrace,
        error: e,
        tag: 'Initialization main',
      );
    }
  }
}

void setCustomErrorWidget() {
  ErrorWidget.builder =
      (FlutterErrorDetails details) => ErrorWidgetMain(details: details);
}

Future<void> initializeDependencies() async {
  hideKeyboard();
  setCustomErrorWidget();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(MessageBubbleModelAdapter())
    ..registerAdapter(SenderTypeAdapter());
  await Hive.openBox<MessageBubbleModel>('chat_messages');

  Bloc.observer = SimpleBlocObserver();
  await setupAllDependencies();
  await Future.wait([
    LocalNotificationService.initialize(),
    sl<ConnectivityController>().connectivityControllerInit(),
    sl<CacheDataHelper>().sharedPreferencesInitialize(),
    sl<EnvVariables>().envVariablesSetup(envType: EnvTypeEnum.dev),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  if (kReleaseMode) {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
