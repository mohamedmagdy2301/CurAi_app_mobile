import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/app/onboarding/onboarding_screen.dart';
import 'package:curai_app_mobile/core/common/functions/build_app_connectivity_controller.dart';
import 'package:curai_app_mobile/core/language/app_localizations_setup.dart';
import 'package:curai_app_mobile/core/routes/app_routes.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class CuraiApp extends StatefulWidget {
  const CuraiApp({required this.environment, super.key});
  final bool environment;

  @override
  _CuraiAppState createState() => _CuraiAppState();
}

class _CuraiAppState extends State<CuraiApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<SettingsCubit>().setTheme(ThemeModeState.system);

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 758.7),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final cubit = context.read<SettingsCubit>();
            return LockOrientation(
              child: MaterialApp(
                debugShowCheckedModeBanner: widget.environment,
                theme: AppTheme.getTheme(
                  context,
                  state.colors,
                  state.themeMode,
                ),
                darkTheme: AppTheme.getTheme(
                  context,
                  state.colors,
                  state.themeMode,
                ),
                themeMode: cubit.getThemeMode(state.themeMode),
                builder: (context, child) => setupConnectivityWidget(child),
                onGenerateRoute: AppRoutes.onGenerateRoute,
                locale: cubit.getLocaleFromState(state.locale),
                supportedLocales: AppLocalSetup.supportedLocales,
                localeResolutionCallback: AppLocalSetup.resolveUserLocale,
                localizationsDelegates: AppLocalSetup.localesDelegates,
                home: const Onboarding(),
              ),
            );
          },
        );
      },
    );
  }
}
