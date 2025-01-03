import 'package:curai_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:curai_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:curai_app_mobile/core/language/app_localizations_setup.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/app_routes.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/main_scaffold_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class CuraiApp extends StatelessWidget {
  const CuraiApp({required this.environment, super.key});
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
            builder: (_, __) => LockOrientation(
              child: MaterialApp(
                debugShowCheckedModeBanner: environment,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                builder: (context, child) =>
                    buildAppConnectivityController(child),
                onGenerateRoute: AppRoutes.onGenerateRoute,
                home: const MainScaffoldUser(),
                locale: Locale(appCubit.currentLocale),
                supportedLocales: AppLocalSetup.supportedLocales,
                localeResolutionCallback:
                    AppLocalSetup.localeResolutionCallback,
                localizationsDelegates: AppLocalSetup.localesDelegates,
              ),
            ),
          );
        },
      ),
    );
  }
}
