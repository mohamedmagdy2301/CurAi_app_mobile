enum ThemeModeState { light, dark, system }

enum LocalizationState { ar, en, system }

enum ColorsPalleteState { orange, blue, green, red, indigo, purple }

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
