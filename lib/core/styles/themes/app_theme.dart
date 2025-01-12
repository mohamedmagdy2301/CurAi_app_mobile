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

    // Text Theme
    TextTheme textTheme() {
      return TextTheme(
        bodyLarge:
            AppTextStyles.bodyLarge(context, color: colorScheme.onSurface),
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
    AppBarTheme appBarTheme() {
      return AppBarTheme(
        titleTextStyle:
            AppTextStyles.appBarTitle(context, color: colorScheme.onPrimary),
        // color: colorScheme,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      );
    }

    // Floating Action Button Theme
    FloatingActionButtonThemeData fabTheme() {
      return FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      );
    }

    // Input Decoration Theme
    InputDecorationTheme inputDecorationTheme() {
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
    CardTheme cardTheme() {
      return CardTheme(
        color: colorScheme.surface,
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      );
    }

    // Elevated Button Theme
    ElevatedButtonThemeData buttonTheme() {
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
    SnackBarThemeData snackBarTheme() {
      return SnackBarThemeData(
        contentTextStyle: AppTextStyles.bodyLarge(context, color: Colors.white),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      );
    }

    return ThemeData(
      colorScheme: colorScheme,
      extensions: [extension!],
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      useMaterial3: true,
      textTheme: textTheme(),
      appBarTheme: appBarTheme(),
      floatingActionButtonTheme: fabTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      cardTheme: cardTheme(),
      elevatedButtonTheme: buttonTheme(),
      snackBarTheme: snackBarTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
