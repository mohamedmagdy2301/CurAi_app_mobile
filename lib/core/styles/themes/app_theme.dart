import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_style_helper.dart';
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
      onPrimary: Colors.white,
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
    required List<ThemeExtension<dynamic>>? extensions,
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
      snackBarTheme: _snackBarTheme(colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Text Theme
  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLarge(color: colorScheme.onSurface),
      bodyMedium: AppTextStyles.bodyMedium(color: colorScheme.onSurface),
      bodySmall: AppTextStyles.bodySmall(
        color: colorScheme.onSurface.withOpacity(0.7),
      ),
      titleLarge: AppTextStyles.titleLarge(color: colorScheme.onSurface),
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
      titleTextStyle: AppTextStyles.appBarTitle(color: colorScheme.onPrimary),
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
    OutlineInputBorder buildBorder(Color color, {double width = 1.0}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        borderSide: BorderSide(color: color),
      );
    }

    return InputDecorationTheme(
      errorBorder: buildBorder(colorScheme.error),
      focusedErrorBorder: buildBorder(colorScheme.error, width: 2),
      errorStyle: AppTextStyles.bodySmall(color: colorScheme.error),
    );
  }

  // Card Theme
  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
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
        elevation: 0,
        fixedSize: Size(800.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  // Snack Bar Theme
  static SnackBarThemeData _snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      contentTextStyle: AppTextStyles.bodyLarge(color: Colors.white),
      backgroundColor: colorScheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
