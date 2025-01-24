import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_style_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/fonts_family_helper.dart';
import 'package:curai_app_mobile/core/styles/themes/app_color_schemes.dart';
import 'package:curai_app_mobile/core/styles/themes/color_extension.dart';
import 'package:flutter/material.dart';

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
        titleTextStyle:
            AppTextStyles.appBarTitle(context, color: colorScheme.onSurface),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      );
    }

    // Input Decoration Theme
    InputDecorationTheme inputDecorationTheme() {
      OutlineInputBorder buildBorder(Color color) {
        return OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(context.setR(8))),
          borderSide: BorderSide(color: color),
        );
      }

      return InputDecorationTheme(
        border: buildBorder(colorScheme.onSecondary),
        errorBorder: buildBorder(colorScheme.error),
        enabledBorder: buildBorder(colorScheme.onSecondary.withAlpha(70)),
        focusedBorder: buildBorder(colorScheme.primary),
        focusedErrorBorder: buildBorder(colorScheme.error),
        errorStyle: AppTextStyles.bodySmall(context, color: colorScheme.error),
        labelStyle:
            AppTextStyles.bodySmall(context, color: colorScheme.onSecondary),
      );
    }

    // Card Theme
    CardTheme cardTheme() {
      return CardTheme(
        color: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            context.setR(8),
          ),
        ),
      );
    }

    // Elevated Button Theme
    ElevatedButtonThemeData buttonTheme() {
      return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: colorScheme.primary,
          elevation: 0,
          fixedSize: Size(context.setW(800), context.setH(50)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.setR(10)),
          ),
        ),
      );
    }

    // Snack Bar Theme
    SnackBarThemeData snackBarTheme() {
      return SnackBarThemeData(
        contentTextStyle: AppTextStyles.bodyLarge(context, color: Colors.white),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.setR(8)),
        ),
      );
    }

    return ThemeData(
      colorScheme: colorScheme,
      extensions: [extension!],
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      useMaterial3: true,
      textTheme: AppTextStyles.getTextTheme(context, colorScheme),
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
