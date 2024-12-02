import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:smartcare_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations_setup.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:smartcare_app_mobile/core/routes/app_routes.dart';
import 'package:smartcare_app_mobile/core/styles/themes/app_theme.dart';

class SmartCareApp extends StatelessWidget {
  const SmartCareApp({required this.environment, super.key});
  final bool environment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit()
        ..changeTheme(
          sharedTheme: SharedPrefManager.getBool(SharedPrefKey.isDarkTheme),
        )
        ..getLocalesSharedPref(),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final appCubit = context.read<AppCubit>();
          return ScreenUtilInit(
            designSize: const Size(360, 758.7),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) => MaterialApp(
              debugShowCheckedModeBanner: environment,
              theme: appCubit.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              builder: (context, child) =>
                  buildAppConnectivityController(child),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              home: const Onboarding(),
              locale: Locale(appCubit.currentLocale),
              supportedLocales: AppLocalSetup.supportedLocales,
              localeResolutionCallback: AppLocalSetup.localeResolutionCallback,
              localizationsDelegates: AppLocalSetup.localesDelegates,
            ),
          );
        },
      ),
    );
  }
}
