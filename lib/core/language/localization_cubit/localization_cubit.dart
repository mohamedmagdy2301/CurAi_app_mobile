import 'dart:io';

import 'package:curai_app_mobile/core/language/localization_cubit/localization_state.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit()
      : super(LocalizationState(locale: LocalizationStateEnum.ar)) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(SharedPrefKey.keyLocale) ?? 'ar';
    if (isClosed) return;

    emit(
      LocalizationState(
        locale: _getLocaleStateFromString(locale),
      ),
    );
  }

  Future<void> setLocale(LocalizationStateEnum locale) async {
    await _setPreference(
      SharedPrefKey.keyLocale,
      _getLocaleStateToString(locale),
    );
    if (isClosed) return;

    emit(
      LocalizationState(
        locale: locale,
      ),
    );
  }

  Future<void> _setPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  LocalizationStateEnum _getLocaleStateFromString(String locale) {
    switch (locale) {
      case 'ar':
        return LocalizationStateEnum.ar;
      case 'en':
        return LocalizationStateEnum.en;
      default:
        return LocalizationStateEnum.system;
    }
  }

  String _getLocaleStateToString(LocalizationStateEnum state) {
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

  Locale getLocaleFromState(LocalizationStateEnum state) {
    switch (state) {
      case LocalizationStateEnum.ar:
        return const Locale('ar');
      case LocalizationStateEnum.en:
        return const Locale('en');
      case LocalizationStateEnum.system:
        return getSystemLocale();
    }
  }
}
