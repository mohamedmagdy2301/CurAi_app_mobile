import 'dart:io';

import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/styles/themes/assets_extension.dart';
import 'package:curai_app_mobile/core/styles/themes/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension SettingsContextExtansions on BuildContext {
  // ! System Theme
  bool get isSystemDark =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  // ! System Locale
  bool get isSystemArabic => Platform.localeName.split('_').first == 'ar';

  // ! Settings Cubit
  SettingsState get stateSettings => watch<SettingsCubit>().state;
  SettingsCubit get cubitSettings => read<SettingsCubit>();
  bool get isStateDark {
    switch (stateSettings.themeMode) {
      case ThemeModeState.light:
        return false;
      case ThemeModeState.dark:
        return true;
      case ThemeModeState.system:
        return isSystemDark;
    }
  }

  bool get isStateArabic {
    switch (cubitSettings.getLocaleFromState(stateSettings.locale)) {
      case const Locale('ar'):
        return true;
      case const Locale('en'):
        return false;
      default:
        return isSystemArabic;
    }
  }

  //! Theme
  MyAssets get assets => Theme.of(this).extension<MyAssets>()!;
  MyColors get colors => Theme.of(this).extension<MyColors>()!;
  TextTheme get textTheme => Theme.of(this).textTheme;

  //! Localization translation
  String translate(String langKey) =>
      AppLocalizations.of(this)!.translate(langKey).toString();
}
