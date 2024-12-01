import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_sizes_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_style_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/fonts_family_helper.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = _createTheme(
    colorScheme: const ColorScheme(
      primary: Colors.blue,
      secondary: Colors.green,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = _createTheme(
    colorScheme: const ColorScheme(
      primary: Colors.black,
      secondary: Colors.grey,
      surface: Colors.black87,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
  );

  // Base Theme Creator
  static ThemeData _createTheme({
    required ColorScheme colorScheme,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      textTheme: _textTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Text Theme
  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      labelLarge: AppTextStyles.bodyMedium(
        color: colorScheme.onSurface,
        fontSize: FontSizesHelper.large,
      ),
      labelMedium: AppTextStyles.bodySmall(
        color: colorScheme.onSurface,
        fontSize: FontSizesHelper.medium,
      ),
      labelSmall: AppTextStyles.bodySmall(
        color: colorScheme.onSurface.withOpacity(0.6),
      ),
      displayLarge: AppTextStyles.titleLarge(
        color: colorScheme.onSurface,
        fontSize: FontSizesHelper.huge,
      ),
      displayMedium: AppTextStyles.titleMedium(
        color: colorScheme.onSurface,
        fontSize: FontSizesHelper.xxLarge,
      ),
      displaySmall: AppTextStyles.titleMedium(
        color: colorScheme.onSurface.withOpacity(0.8),
      ),
      headlineLarge: AppTextStyles.titleLarge(
        color: colorScheme.onSurface,
      ),
      headlineMedium: AppTextStyles.titleMedium(
        color: colorScheme.onSurface,
      ),
      headlineSmall: AppTextStyles.bodyLarge(
        color: colorScheme.onSurface,
      ),
      bodyLarge: AppTextStyles.bodyLarge(
        color: colorScheme.onSurface,
      ),
      bodyMedium: AppTextStyles.bodyMedium(
        color: colorScheme.onSurface,
      ),
      bodySmall: AppTextStyles.bodySmall(
        color: colorScheme.onSurface,
      ),
      titleLarge: AppTextStyles.titleLarge(
        color: colorScheme.onSurface,
        fontSize: FontSizesHelper.huge,
      ),
      titleMedium: AppTextStyles.titleMedium(
        color: colorScheme.onSurface.withOpacity(0.8),
      ),
      titleSmall: AppTextStyles.bodySmall(
        color: colorScheme.onSurface.withOpacity(0.6),
      ),
    );
  }

  // AppBar Theme
  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      titleTextStyle: AppTextStyles.appBarTitle(
        color: colorScheme.onPrimary,
      ),
      color: colorScheme.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
    );
  }
}
