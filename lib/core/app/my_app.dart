import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/screens/no_internet_connection.dart';
import 'package:curai_app_mobile/curai_app.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.environment,
    required this.savedThemeColor,
    required this.savedThemeMode,
    super.key,
  });
  final bool environment;
  final Color savedThemeColor;
  final AdaptiveThemeMode savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sl<ConnectivityController>().isInternetNotifier,
      builder: (_, value, __) {
        if (value) {
          return CuraiApp(
            environment: environment,
            savedThemeColor: savedThemeColor,
            savedThemeMode: savedThemeMode,
          );
        }
        return const NoInternetConnection();
      },
    );
  }
}
