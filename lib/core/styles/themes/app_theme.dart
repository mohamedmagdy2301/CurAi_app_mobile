// theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:smartcare_app_mobile/core/styles/themes/assets_extension.dart';
import 'package:smartcare_app_mobile/core/styles/themes/color_extension.dart';

class AppTheme {
  static ThemeData lightTheme = _createTheme(
    colorScheme: const ColorScheme(
      primary: ColorsLight.primaryColor,
      secondary: ColorsLight.accentColor,
      surface: ColorsLight.backgroundColor,
      error: ColorsLight.errorColor,
      onPrimary: Color.fromARGB(255, 198, 198, 198),
      onSecondary: Colors.black,
      onSurface: ColorsLight.textColor,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    extensions: <ThemeExtension<dynamic>>[MyColors.light, MyAssets.light],
  );

  static ThemeData darkTheme = _createTheme(
    colorScheme: const ColorScheme(
      primary: ColorsDark.primaryColor,
      secondary: ColorsDark.accentColor,
      surface: ColorsDark.backgroundColor,
      error: ColorsDark.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ColorsDark.textColor,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    extensions: <ThemeExtension<dynamic>>[MyColors.dark, MyAssets.dark],
  );

  static ThemeData _createTheme({
    required ColorScheme colorScheme,
    required Iterable<ThemeExtension<dynamic>> extensions,
  }) {
    return ThemeData(
      extensions: extensions,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colorScheme.onSurface),
        bodySmall: TextStyle(color: colorScheme.onSurface),
        titleSmall: TextStyle(color: colorScheme.onSurface),
        titleLarge: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeightHelper.bold,
        ),
        bodyMedium: TextStyle(color: colorScheme.onSurface),
        titleMedium: TextStyle(color: colorScheme.onSurface.withOpacity(0.8)),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeightHelper.bold,
          fontSize: 25,
        ),
        color: colorScheme.primary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.secondary, width: 2),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        errorStyle: TextStyle(color: colorScheme.error),
      ),
      cardTheme: CardTheme(
        color: colorScheme.brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF2C2C2C),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onSecondary,
          backgroundColor: colorScheme.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
