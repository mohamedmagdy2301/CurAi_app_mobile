import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  bool isDark = false;
  void changeTheme(bool? currentThemeSharedPref) {
    if (currentThemeSharedPref != null) {
      isDark = currentThemeSharedPref;
      emit(AppThemeChanged(isDark: isDark));
    } else {
      isDark = !isDark;
      emit(AppThemeChanged(isDark: isDark));
    }
  }

  void changeLocalization() {
    emit(AppLocalizationChanged(locale: 'en'));
    emit(AppLocalizationChanged(locale: 'ar'));
  }
}
