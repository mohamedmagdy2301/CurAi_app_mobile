import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/screens/no_internet_connection.dart';
import 'package:curai_app_mobile/curai_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.environment,
    super.key,
  });
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => ValueListenableBuilder(
        valueListenable: sl<ConnectivityController>().isInternetNotifier,
        builder: (_, value, __) {
          if (value) {
            return CuraiApp(
              environment: environment,
            );
          }
          return const NoInternetConnection();
        },
      ),
    );
  }
}
