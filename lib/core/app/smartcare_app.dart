import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:smartcare_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations_setup.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';
import 'package:smartcare_app_mobile/core/styles/themes/app_theme.dart';
import 'package:smartcare_app_mobile/test_one.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..changeTheme(
          sharedTheme: SharedPrefManager.getBoolean(SharedPrefKey.isDarkTheme),
        ),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final cubitApp = context.read<AppCubit>();
          return MaterialApp(
            debugShowCheckedModeBanner: environment,
            theme: cubitApp.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
            builder: (context, child) => buildAppConnectivityController(child),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const TestOne(),
            locale: const Locale('en'),
            supportedLocales: AppLocalSetup.supportedLocales,
            localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
            localizationsDelegates: AppLocalSetup.localesDelegates,
          );
        },
      ),
    );
  }
}
