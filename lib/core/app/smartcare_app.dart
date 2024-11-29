import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/common/screens/no_internet_connection.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';
import 'package:smartcare_app_mobile/core/styles/themes/app_theme.dart';
import 'package:smartcare_app_mobile/test_one.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          ConnectivityController.instance.isInternetConnectedNotifier,
      builder: (_, value, __) {
        if (value) {
          return MaterialApp(
            debugShowCheckedModeBanner: environment,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            builder: (context, child) {
              return Scaffold(
                body: Builder(
                  builder: (context) {
                    ConnectivityController.instance.init();
                    return child!;
                  },
                ),
              );
            },
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const TestOne(),
          );
        }
        return const NoInternetConnection();
      },
    );
  }
}
