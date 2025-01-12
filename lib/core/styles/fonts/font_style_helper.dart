import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextTheme getTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: displayLarge(color: colorScheme.onSurface),
      displayMedium: displayMedium(color: colorScheme.onSurface),
      displaySmall: displaySmall(color: colorScheme.onSurface),
      headlineLarge: headlineLarge(color: colorScheme.onSurface),
      headlineMedium: headlineMedium(color: colorScheme.onSurface),
      headlineSmall: headlineSmall(color: colorScheme.onSurface),
      labelLarge: labelLarge(color: colorScheme.onSurface),
      labelMedium: labelMedium(color: colorScheme.onSurface),
      labelSmall: labelSmall(color: colorScheme.onSurface),
      bodyLarge: bodyLarge(color: colorScheme.onSurface),
      bodyMedium: bodyMedium(color: colorScheme.onSurface),
      bodySmall: bodySmall(color: colorScheme.onSurface.withAlpha(160)),
      titleLarge: titleLarge(color: colorScheme.onSurface),
      titleMedium: titleMedium(color: colorScheme.onSurface.withAlpha(200)),
      titleSmall: bodySmall(color: colorScheme.onSurface.withAlpha(160)),
    );
  }

  static TextStyle bodySmall({required Color color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle labelSmall({required Color color}) => TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle labelLarge({required Color color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.bold,
      );

  static TextStyle labelMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
      );

  static TextStyle bodyMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle bodyLarge({required Color color}) => TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle titleMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.medium,
      );

  static TextStyle headlineSmall({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.semiBold,
        fontSize: 18.sp,
      );

  static TextStyle titleLarge({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 20.sp,
      );

  static TextStyle headlineMedium({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: 20.sp,
      );

  static TextStyle displaySmall({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: 22.sp,
      );

  static TextStyle displayMedium({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.black,
        fontSize: 28.sp,
      );

  static TextStyle displayLarge({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.black,
        fontSize: 34.sp,
      );

  static TextStyle appBarTitle({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 22.sp,
      );

  static TextStyle headlineLarge({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: 24.sp,
      );
}
