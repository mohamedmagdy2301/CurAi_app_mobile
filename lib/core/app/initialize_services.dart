import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/services/local_notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/helper/bolc_observer.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/home/data/models/favorite_doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class InitializeServices {
  static Future<void> initializeServices() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    hideKeyboard();

    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final appDocumentDir =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
    }
    Hive
      ..registerAdapter(MessageBubbleModelAdapter())
      ..registerAdapter(SenderTypeAdapter())
      ..registerAdapter(FavoriteDoctorAdapter())
      ..registerAdapter(DoctorInfoModelAdapter())
      ..registerAdapter(DoctorReviewsAdapter())
      ..registerAdapter(SpecializationsModelAdapter());

    Bloc.observer = SimpleBlocObserver();

    await initializeServiceLocator();

    await Future.wait([
      sl<LocalNotificationService>().initialize(),
      sl<ConnectivityController>().connectivityControllerInit(),
      sl<CacheDataManager>().sharedPreferencesInitialize(),
      sl<AppEnvironment>().initializeEnvironment(),
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    ]);
    clearCachHomeData();

    if (kReleaseMode) {
      await Future<void>.delayed(const Duration(microseconds: 300));
    }

    FlutterNativeSplash.remove();
  }
}
