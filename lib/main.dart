import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/smartcare_app.dart';
import 'package:smartcare_app_mobile/firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const SmartCareApp(environment: false));
}
