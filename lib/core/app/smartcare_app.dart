import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/common/screens/no_internet_connection.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations_setup.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';
import 'package:smartcare_app_mobile/core/styles/themes/app_theme.dart';
import 'package:smartcare_app_mobile/test_one.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isInternetNotifier,
      builder: (_, value, __) {
        if (value) {
          return MaterialApp(
            debugShowCheckedModeBanner: environment,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            builder: (context, child) => buildAppConnectivityController(child),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const TestOne(),
            locale: const Locale('en'),
            supportedLocales: AppLocalSetup.supportedLocales,
            localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
            localizationsDelegates: AppLocalSetup.localesDelegates,
          );
        }
        return const NoInternetConnection();
      },
    );
  }
}
