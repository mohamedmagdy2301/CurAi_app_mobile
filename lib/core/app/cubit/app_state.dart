part of 'app_cubit.dart';

class AppState {}

final class AppInitial extends AppState {}

final class AppThemeChanged extends AppState {
  AppThemeChanged({required this.isDark});

  final bool isDark;
}

final class AppLocalizationChanged extends AppState {
  AppLocalizationChanged({required this.locale});

  final Locale locale;
}
