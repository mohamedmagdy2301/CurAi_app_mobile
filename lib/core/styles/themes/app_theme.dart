import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_style_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/fonts_family_helper.dart';
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
    final extension = MyColors.themeExtensions[themeMode]![palette];

    // AppBar Theme
    AppBarTheme appBarTheme() {
      return AppBarTheme(
        titleTextStyle: AppTextStyles.appBarTitle(color: colorScheme.onSurface),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
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
        border: buildBorder(colorScheme.onSecondary),
        errorBorder: buildBorder(colorScheme.error),
        enabledBorder: buildBorder(colorScheme.onSecondary.withAlpha(70)),
        focusedBorder: buildBorder(colorScheme.primary, width: 1.w),
        focusedErrorBorder: buildBorder(colorScheme.error, width: 2.w),
        errorStyle: AppTextStyles.bodySmall(color: colorScheme.error),
        labelStyle: AppTextStyles.bodySmall(color: colorScheme.onSecondary),
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
          foregroundColor: Colors.white,
          backgroundColor: colorScheme.primary,
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
        contentTextStyle: AppTextStyles.bodyLarge(color: Colors.white),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
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
      textTheme: AppTextStyles.getTextTheme(colorScheme),
      fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      cardTheme: cardTheme(),
      elevatedButtonTheme: buttonTheme(),
      snackBarTheme: snackBarTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
