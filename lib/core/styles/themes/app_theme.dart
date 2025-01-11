import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/themes/app_color_schemes.dart';
import 'package:curai_app_mobile/core/styles/themes/color_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(
    ColorsPalleteState palette,
    ThemeModeState themeMode,
  ) {
    final colorScheme = AppColorSchemes.generateColorScheme(
      palette: palette,
      themeMode: themeMode,
    );
    final extension = themeExtensions[themeMode]![palette];

    return ThemeData(
      colorScheme: colorScheme,
      extensions: [extension!],
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      useMaterial3: true,
      // appBarTheme: AppBarTheme(
      //   backgroundColor: colorScheme.
      //   foregroundColor: colorScheme.onPrimary,
      // ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
