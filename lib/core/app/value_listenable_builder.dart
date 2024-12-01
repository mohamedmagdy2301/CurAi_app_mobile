import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/common/screens/no_internet_connection.dart';
import 'package:smartcare_app_mobile/core/di/dependency_injection.dart';
import 'package:smartcare_app_mobile/smartcare_app.dart';

class ConnectionInternetListener extends StatelessWidget {
  const ConnectionInternetListener({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sl<ConnectivityController>().isInternetNotifier,
      builder: (_, value, __) {
        if (value) {
          return SmartCareApp(environment: environment);
        }
        return const NoInternetConnection();
      },
    );
  }
}
