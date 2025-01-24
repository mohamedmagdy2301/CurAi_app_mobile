import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextTheme getTextTheme(BuildContext context, ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: displayLarge(context, color: colorScheme.onSurface),
      displayMedium: displayMedium(context, color: colorScheme.onSurface),
      displaySmall: displaySmall(context, color: colorScheme.onSurface),
      headlineLarge: headlineLarge(context, color: colorScheme.onSurface),
      headlineMedium: headlineMedium(context, color: colorScheme.onSurface),
      headlineSmall: headlineSmall(context, color: colorScheme.onSurface),
      labelLarge: labelLarge(context, color: colorScheme.onSurface),
      labelMedium: labelMedium(context, color: colorScheme.onSurface),
      labelSmall: labelSmall(context, color: colorScheme.onSurface),
      bodyLarge: bodyLarge(context, color: colorScheme.onSurface),
      bodyMedium: bodyMedium(context, color: colorScheme.onSurface),
      bodySmall: bodySmall(context, color: colorScheme.onSurface),
      titleLarge: titleLarge(context, color: colorScheme.onSurface),
      titleMedium: titleMedium(context, color: colorScheme.onSurface),
      titleSmall: bodySmall(context, color: colorScheme.onSurface),
    );
  }

  static TextStyle bodySmall(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(12),
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle labelSmall(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(12),
        fontWeight: FontWeightHelper.semiBold,
      );

  static TextStyle labelLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(14),
        fontWeight: FontWeightHelper.bold,
      );

  static TextStyle labelMedium(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(14),
        fontWeight: FontWeightHelper.medium,
      );

  static TextStyle bodyMedium(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(14),
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle bodyLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(16),
        fontWeight: FontWeightHelper.regular,
      );

  static TextStyle titleMedium(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: context.setSp(18),
        fontWeight: FontWeightHelper.medium,
      );

  static TextStyle headlineSmall(
    BuildContext context, {
    required Color color,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.semiBold,
        fontSize: context.setSp(18),
      );

  static TextStyle titleLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: context.setSp(20),
      );

  static TextStyle headlineMedium(
    BuildContext context, {
    required Color color,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: context.setSp(20),
      );

  static TextStyle displaySmall(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: context.setSp(22),
      );

  static TextStyle displayMedium(
    BuildContext context, {
    required Color color,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.black,
        fontSize: context.setSp(28),
      );

  static TextStyle displayLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.black,
        fontSize: context.setSp(34),
      );

  static TextStyle appBarTitle(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: context.setSp(22),
      );

  static TextStyle headlineLarge(
    BuildContext context, {
    required Color color,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.extraBold,
        fontSize: context.setSp(24),
      );
}
