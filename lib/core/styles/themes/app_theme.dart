import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/fonts_family_helper.dart';
import 'package:smartcare_app_mobile/core/styles/themes/assets_extension.dart';
import 'package:smartcare_app_mobile/core/styles/themes/color_extension.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = _createTheme(
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

  // Dark Theme
  static final ThemeData darkTheme = _createTheme(
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

  // Base Theme Creator
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
      fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      textTheme: _textTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme),
      floatingActionButtonTheme: _fabTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      elevatedButtonTheme: _buttonTheme(colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      snackBarTheme: _snackBarTheme(colorScheme),
    );
  }

  // Text Theme
  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      bodyLarge: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      bodySmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      titleSmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      titleLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeightHelper.bold,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      bodyMedium: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      titleMedium: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.8),
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
    );
  }

  // App Bar Theme
  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontWeight: FontWeightHelper.bold,
        fontSize: 25,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      color: colorScheme.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
    );
  }

  // Floating Action Button Theme
  static FloatingActionButtonThemeData _fabTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
    );
  }

  // Input Decoration Theme
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    OutlineInputBorder borderStyle({required Color color, double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationTheme(
      focusedBorder: borderStyle(color: colorScheme.secondary, width: 2),
      enabledBorder: borderStyle(color: colorScheme.onSurface.withOpacity(0.5)),
      errorBorder: borderStyle(color: colorScheme.error),
      focusedErrorBorder: borderStyle(color: colorScheme.error, width: 2),
      labelStyle: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.8),
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      errorStyle: TextStyle(
        color: colorScheme.error,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
    );
  }

  // Card Theme
  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF2C2C2C),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  // Elevated Button Theme
  static ElevatedButtonThemeData _buttonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onSecondary,
        backgroundColor: colorScheme.secondary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Snack Bar Theme
  static SnackBarThemeData _snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeightHelper.medium,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      ),
      actionTextColor: Colors.black,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
