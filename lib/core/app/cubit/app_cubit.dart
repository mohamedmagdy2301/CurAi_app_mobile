import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  bool isDark = false;
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

  void changeLocalization() {
    emit(AppLocalizationChanged(locale: 'en'));
    emit(AppLocalizationChanged(locale: 'ar'));
  }
}
