import 'dart:ui';

import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:curai_app_mobile/core/styles/colors/colors_light.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';

class AppColorSchemes {
  static ColorScheme generateColorScheme({
    required ColorsPalleteState palette,
    required ThemeModeState themeMode,
  }) {
    final paletteData = getPaletteData(themeMode, palette)!;

    return ColorScheme(
      primary: paletteData.primary,
      secondary: paletteData.secondary,
      surface: paletteData.background,
      error: paletteData.error,
      onPrimary: Colors.white,
      onSecondary:
          themeMode == ThemeModeState.light ? Colors.black : Colors.white,
      onSurface: paletteData.text,
      onError: Colors.white,
      brightness: themeMode == ThemeModeState.light
          ? Brightness.light
          : Brightness.dark,
    );
  }

  static ThemePaletteModel? getPaletteData(
    ThemeModeState themeMode,
    ColorsPalleteState palette,
  ) {
    switch (themeMode) {
      case ThemeModeState.light:
        return lightPalettes[palette];
      case ThemeModeState.dark:
        return darkPalettes[palette];
      case ThemeModeState.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkPalettes[palette]
            : lightPalettes[palette];
    }
  }
}
