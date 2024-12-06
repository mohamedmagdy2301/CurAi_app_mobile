import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:smartcare_app_mobile/core/utils/constants.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  bool isDark = kDefaultThemeIsLight;

  String currentLocale = kDefaultLanguage;
  Future<void> changeTheme({bool? sharedTheme}) async {
    if (sharedTheme != null) {
      isDark = sharedTheme;
      emit(AppThemeChanged(isDark: isDark));
    } else {
      isDark = !isDark;
      await saveThemeChanged();
      emit(AppThemeChanged(isDark: isDark));
    }
  }

  Future<bool> saveThemeChanged() {
    return SharedPrefManager.setData(
      key: SharedPrefKey.isDarkTheme,
      value: isDark,
    );
  }

  void getLocalesSharedPref() {
    final result = SharedPrefManager.containPreference(SharedPrefKey.language)
        ? SharedPrefManager.getString(SharedPrefKey.language)
        : kDefaultLanguage;
    currentLocale = result!;
    emit(AppLocalizationChanged(locale: Locale(currentLocale)));
  }

  Future<void> _changeLocales(String locale) async {
    await saveLocalChanged(locale);
    currentLocale = locale;
    emit(AppLocalizationChanged(locale: Locale(currentLocale)));
  }

  Future<bool> saveLocalChanged(String locale) {
    return SharedPrefManager.setData(
      key: SharedPrefKey.language,
      value: locale,
    );
  }

  void toArabic() => _changeLocales('ar');

  void toEnglish() => _changeLocales('en');
}
