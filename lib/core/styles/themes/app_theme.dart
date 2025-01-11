import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_style_helper.dart';
import 'package:curai_app_mobile/core/styles/themes/app_color_schemes.dart';
import 'package:curai_app_mobile/core/styles/themes/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData getTheme(
    BuildContext context,
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
      textTheme: _textTheme(context, colorScheme),
      appBarTheme: _appBarTheme(context, colorScheme),
      floatingActionButtonTheme: _fabTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(context, colorScheme),
      cardTheme: _cardTheme(colorScheme),
      elevatedButtonTheme: _buttonTheme(colorScheme),
      snackBarTheme: _snackBarTheme(context, colorScheme),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Text Theme
  static TextTheme _textTheme(BuildContext context, ColorScheme colorScheme) {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLarge(context, color: colorScheme.onSurface),
      bodyMedium:
          AppTextStyles.bodyMedium(context, color: colorScheme.onSurface),
      bodySmall: AppTextStyles.bodySmall(
        context,
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      titleLarge:
          AppTextStyles.titleLarge(context, color: colorScheme.onSurface),
      titleMedium: AppTextStyles.titleMedium(
        context,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      titleSmall: AppTextStyles.bodySmall(
        context,
        color: colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  // AppBar Theme
  static AppBarTheme _appBarTheme(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return AppBarTheme(
      titleTextStyle:
          AppTextStyles.appBarTitle(context, color: colorScheme.onPrimary),
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
  static InputDecorationTheme _inputDecorationTheme(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    OutlineInputBorder buildBorder(Color color, {double width = 1.0}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        borderSide: BorderSide(color: color, width: width.w),
      );
    }

    return InputDecorationTheme(
      errorBorder: buildBorder(colorScheme.error),
      focusedErrorBorder: buildBorder(colorScheme.error, width: 2.w),
      errorStyle: AppTextStyles.bodySmall(context, color: colorScheme.error),
    );
  }

  // Card Theme
  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
  static SnackBarThemeData _snackBarTheme(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return SnackBarThemeData(
      contentTextStyle: AppTextStyles.bodyLarge(context, color: Colors.white),
      backgroundColor: colorScheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
