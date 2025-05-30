// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/app_localizations_setup.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_state.dart';
import 'package:curai_app_mobile/core/routes/app_routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/core/utils/helper/build_app_connectivity_controller.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/layout/screens/main_scaffold_user.dart';
import 'package:curai_app_mobile/features/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class CuraiApp extends StatefulWidget {
  const CuraiApp({super.key});

  @override
  State<CuraiApp> createState() => _CuraiAppState();
}

class _CuraiAppState extends State<CuraiApp> {
  Color selectedColor = AppColors.primary;
  AdaptiveThemeMode savedThemeMode = AdaptiveThemeMode.system;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAppSettings();
    });
  }

  Future<void> _loadAppSettings() async {
    try {
      final themeModeString = await di
          .sl<CacheDataManager>()
          .getData(key: SharedPrefKey.saveThemeMode);
      savedThemeMode = _getThemeModeFromString(themeModeString as String?);

      final isDark = savedThemeMode == AdaptiveThemeMode.dark ||
          (savedThemeMode == AdaptiveThemeMode.system &&
              WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark);

      final colors = isDark ? darkColors : lightColors;

      final savedColorValue = await di
          .sl<CacheDataManager>()
          .getData(key: SharedPrefKey.keyThemeColor);

      if (savedColorValue != null && savedColorValue is int) {
        selectedColor = Color(savedColorValue);
      } else {
        selectedColor = colors.first;
        await di.sl<CacheDataManager>().setData(
              key: SharedPrefKey.keyThemeColor,
              value: selectedColor.value,
            );
      }

      if (mounted) {
        setState(() {
          isInitialized = true;
        });
      }
    } on Exception catch (e) {
      // Handle initialization errors gracefully
      log('Error loading app settings: $e');
      if (mounted) {
        setState(() {
          isInitialized = true;
        });
      }
    }
  }

  AdaptiveThemeMode _getThemeModeFromString(String? themeModeString) {
    switch (themeModeString) {
      case 'light':
        return AdaptiveThemeMode.light;
      case 'dark':
        return AdaptiveThemeMode.dark;
      default:
        return AdaptiveThemeMode.system;
    }
  }

  Widget _getInitialScreen() {
    if (getIsFirstLaunch()) {
      return const OnboardingScreen();
    } else if (getIsLogin()) {
      return const MainScaffoldUser();
    } else {
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: di.sl<AppEnvironment>().debugMode,
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: selectedColor),
          scaffoldBackgroundColor: const Color(0xffF1F1F1),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(primary: selectedColor),
          scaffoldBackgroundColor: const Color(0xff161616),
        ),
        home: Scaffold(
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: const Center(
              child: CustomLoadingWidget(height: 60, width: 60),
            ),
          ),
        ),
      );
    }

    return LockOrientation(
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          final cubit = context.read<LocalizationCubit>();
          return AdaptiveTheme(
            light: AppThemeData.lightTheme(
              context.isStateArabic ? 'Cairo' : 'Poppins',
              selectedColor,
            ),
            dark: AppThemeData.darkTheme(
              context.isStateArabic ? 'Cairo' : 'Poppins',
              selectedColor,
            ),
            initial: savedThemeMode,
            builder: (theme, darkTheme) => BlocProvider(
              create: (context) => di.sl<FavoritesCubit>(),
              child: MaterialApp(
                navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
                theme: theme,
                darkTheme: darkTheme,
                debugShowCheckedModeBanner: di.sl<AppEnvironment>().debugMode,
                builder: (context, child) {
                  // Ensure child is properly wrapped before setup
                  if (child == null) return const SizedBox.shrink();
                  return setupConnectivityWidget(child);
                },
                onGenerateRoute: AppRoutes.onGenerateRoute,
                locale: cubit.getLocaleFromState(state.locale),
                supportedLocales: AppLocalSetup.supportedLocales,
                localeResolutionCallback: AppLocalSetup.resolveUserLocale,
                localizationsDelegates: AppLocalSetup.localesDelegates,
                home: _getInitialScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
