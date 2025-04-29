// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_state.dart';
import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/app_localizations_setup.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/app_routes.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/core/utils/helper/build_app_connectivity_controller.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/layout/cubit/navigation_cubit.dart';
import 'package:curai_app_mobile/features/layout/screens/main_scaffold_user.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class CuraiApp extends StatefulWidget {
  const CuraiApp({
    required this.environment,
    required this.savedThemeColor,
    required this.savedThemeMode,
    super.key,
  });
  final bool environment;
  final Color savedThemeColor;
  final AdaptiveThemeMode savedThemeMode;

  @override
  _CuraiAppState createState() => _CuraiAppState();
}

class _CuraiAppState extends State<CuraiApp> {
  dynamic isLoggedIn =
      CacheDataHelper.getData(key: SharedPrefKey.keyIsLoggedIn) ?? false;
  dynamic isFirstLaunch =
      CacheDataHelper.getData(key: SharedPrefKey.keyIsFirstLaunch) ?? true;
  Widget navigationToInitScreen() {
    if (isFirstLaunch as bool) {
      return const OnboardingScreen();
    } else {
      if (isLoggedIn as bool) {
        return const MainScaffoldUser();
      } else {
        return const LoginScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => LockOrientation(
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          child: BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, state) {
              final cubit = context.read<LocalizationCubit>();
              return AdaptiveTheme(
                light: AppThemeData.lightTheme(
                  context.isStateArabic ? 'Cairo' : 'Poppins',
                  widget.savedThemeColor,
                ),
                dark: AppThemeData.darkTheme(
                  context.isStateArabic ? 'Cairo' : 'Poppins',
                  widget.savedThemeColor,
                ),
                initial: widget.savedThemeMode,
                builder: (theme, darkTheme) => MultiBlocProvider(
                  providers: [
                    BlocProvider<AppointmentPatientCubit>(
                      create: (context) => di.sl<AppointmentPatientCubit>(),
                    ),
                    BlocProvider<HomeCubit>(
                      create: (context) => di.sl<HomeCubit>(),
                    ),
                    BlocProvider<NavigationCubit>(
                      create: (context) => NavigationCubit(),
                    ),
                  ],
                  child: MaterialApp(
                    navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
                    theme: theme,
                    darkTheme: darkTheme,
                    debugShowCheckedModeBanner: widget.environment,
                    builder: (context, child) => setupConnectivityWidget(child),
                    onGenerateRoute: AppRoutes.onGenerateRoute,
                    locale: cubit.getLocaleFromState(state.locale),
                    supportedLocales: AppLocalSetup.supportedLocales,
                    localeResolutionCallback: AppLocalSetup.resolveUserLocale,
                    localizationsDelegates: AppLocalSetup.localesDelegates,
                    home: navigationToInitScreen(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
