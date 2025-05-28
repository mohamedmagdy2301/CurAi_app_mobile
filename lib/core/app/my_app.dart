import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/utils/screens/no_internet_connection.dart';
import 'package:curai_app_mobile/curai_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) => ValueListenableBuilder(
        valueListenable: sl<ConnectivityController>().isInternetNotifier,
        builder: (_, value, __) {
          if (value) {
            return BlocProvider(
              create: (context) => LocalizationCubit()..loadSettings(),
              child: const CuraiApp(),
            );
          }
          return const NoInternetConnection();
        },
      ),
    );
  }
}
