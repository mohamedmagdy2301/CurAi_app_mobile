enum ThemeModeState { light, dark, system }

enum LocalizationState { ar, en, system }

enum ColorsPalleteState { blue, green }

class SettingsState {
  SettingsState({
    required this.themeMode,
    required this.locale,
    required this.colors,
  });
  final ThemeModeState themeMode;
  final LocalizationState locale;
  final ColorsPalleteState colors;
}
