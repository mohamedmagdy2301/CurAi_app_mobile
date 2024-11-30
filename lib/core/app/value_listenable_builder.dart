import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/app/smartcare_app.dart';
import 'package:smartcare_app_mobile/core/common/screens/no_internet_connection.dart';

class ConnectionInternetListener extends StatelessWidget {
  const ConnectionInternetListener({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isInternetNotifier,
      builder: (_, value, __) {
        if (value) {
          return SmartCareApp(environment: environment);
        }
        return const NoInternetConnection();
      },
    );
  }
}
