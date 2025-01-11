import 'dart:io';

import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            themeMode: ThemeModeState.system,
            locale: LocalizationState.system,
            colors: ColorsPalleteState.orange,
          ),
        ) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(SharedPrefKey.keyTheme) ?? 'system';
    final locale = prefs.getString(SharedPrefKey.keyLocale) ?? 'system';
    final colors = prefs.getString(SharedPrefKey.keyColors) ?? 'orange';

    emit(
      SettingsState(
        themeMode: _getThemeStateFromString(theme),
        locale: _getLocaleStateFromString(locale),
        colors: _getColorsStateFromString(colors),
      ),
    );
  }

  Future<void> setColors(ColorsPalleteState colors) async {
    await _setPreference(
      SharedPrefKey.keyColors,
      _getColorsStateToString(colors),
    );
    emit(
      SettingsState(
        themeMode: state.themeMode,
        locale: state.locale,
        colors: colors,
      ),
    );
  }

  ColorsPalleteState _getColorsStateFromString(String colors) {
    switch (colors) {
      case 'blue':
        return ColorsPalleteState.blue;
      case 'red':
        return ColorsPalleteState.red;
      case 'green':
        return ColorsPalleteState.green;
      case 'indigo':
        return ColorsPalleteState.indigo;
      case 'orange':
        return ColorsPalleteState.orange;
      case 'purple':
        return ColorsPalleteState.purple;
      default:
        return ColorsPalleteState.orange;
    }
  }

  String _getColorsStateToString(ColorsPalleteState state) {
    return state.toString().split('.').last;
  }

  Future<void> setTheme(ThemeModeState themeMode) async {
    await _setPreference(
      SharedPrefKey.keyTheme,
      _getThemeStateToString(themeMode),
    );
    emit(
      SettingsState(
        themeMode: themeMode,
        locale: state.locale,
        colors: state.colors,
      ),
    );
  }

  Future<void> setLocale(LocalizationState locale) async {
    await _setPreference(
      SharedPrefKey.keyLocale,
      _getLocaleStateToString(locale),
    );
    emit(
      SettingsState(
        themeMode: state.themeMode,
        locale: locale,
        colors: state.colors,
      ),
    );
  }

  Future<void> _setPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  ThemeModeState _getThemeStateFromString(String theme) {
    switch (theme) {
      case 'light':
        return ThemeModeState.light;
      case 'dark':
        return ThemeModeState.dark;
      default:
        return ThemeModeState.system;
    }
  }

  String _getThemeStateToString(ThemeModeState state) {
    return state.toString().split('.').last;
  }

  LocalizationState _getLocaleStateFromString(String locale) {
    switch (locale) {
      case 'ar':
        return LocalizationState.ar;
      case 'en':
        return LocalizationState.en;
      default:
        return LocalizationState.system;
    }
  }

  ThemeMode getThemeMode(ThemeModeState themeMode) {
    switch (themeMode) {
      case ThemeModeState.light:
        return ThemeMode.light;
      case ThemeModeState.dark:
        return ThemeMode.dark;
      case ThemeModeState.system:
        return ThemeMode.system;
    }
  }

  String _getLocaleStateToString(LocalizationState state) {
    return state.toString().split('.').last;
  }

  Locale getSystemLocale() {
    switch (Platform.localeName.split('_').first) {
      case 'ar':
        return const Locale('ar');
      case 'en':
        return const Locale('en');
      default:
        return const Locale('en');
    }
  }

  Locale getLocaleFromState(LocalizationState state) {
    switch (state) {
      case LocalizationState.ar:
        return const Locale('ar');
      case LocalizationState.en:
        return const Locale('en');
      case LocalizationState.system:
        return getSystemLocale();
    }
  }
}
