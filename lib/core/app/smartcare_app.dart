import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations_setup.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';
import 'package:smartcare_app_mobile/core/styles/themes/app_theme.dart';
import 'package:smartcare_app_mobile/test_one.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: environment,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: 0 == 0 ? ThemeMode.light : ThemeMode.dark,
      builder: (context, child) => buildAppConnectivityController(child),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const TestOne(),
      locale: const Locale('en'),
      supportedLocales: AppLocalSetup.supportedLocales,
      localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
      localizationsDelegates: AppLocalSetup.localesDelegates,
    );
  }
}
