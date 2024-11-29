import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/env.variables.dart';
import 'package:smartcare_app_mobile/core/app/value_listenable_builder.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:smartcare_app_mobile/core/simple_bloc_observer/bolc_observer.dart';
import 'package:smartcare_app_mobile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Future.wait([
    SharedPreferencesManager.sharedPreferencesInitialize(),
  ]);
  await EnvVariables.instance.init(envType: EnvTypeEnum.dev);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ConnectionInternetListener(
      environment: EnvVariables.instance.debugMode,
    ),
  );
}
