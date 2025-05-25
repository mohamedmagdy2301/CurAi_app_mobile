// ignore_for_file: depend_on_referenced_packages

import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/app/my_app.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/services/local_notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await initializeServices();
  runApp(MyApp(isDebugMode: sl<EnvVariables>().debugMode));
  FlutterNativeSplash.remove();
}

Future<void> initializeServices() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  hideKeyboard();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(MessageBubbleModelAdapter())
    ..registerAdapter(SenderTypeAdapter())
    // favorite doctor
    ..registerAdapter(FavoriteDoctorAdapter());

  await Hive.openBox<MessageBubbleModel>('chat_messages');

  /// Initialize the Bloc observer
  Bloc.observer = SimpleBlocObserver();

  /// Initialize the service locator
  await initializeServiceLocator();

  await Future.wait([
    LocalNotificationService.initialize(),
    sl<ConnectivityController>().connectivityControllerInit(),
    sl<CacheDataHelper>().sharedPreferencesInitialize(),
    sl<EnvVariables>().envVariablesSetup(envType: EnvTypeEnum.dev),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  if (kReleaseMode) {
    await Future<void>.delayed(const Duration(microseconds: 300));
  }
}
