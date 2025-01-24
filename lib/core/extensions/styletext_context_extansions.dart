import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StyleTextContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;

  TextStyle get styleRegular10 => textTheme.bodySmall!.copyWith(
        fontWeight: FontWeightHelper.regular,
        fontSize: 10.sp,
      );

  TextStyle get styleLight12 => textTheme.bodySmall!.copyWith(
        fontWeight: FontWeightHelper.light,
      );

  TextStyle get styleRegular12 => textTheme.bodySmall!;

  TextStyle get styleSemiBold12 => textTheme.labelSmall!;
  TextStyle get styleBold12 => textTheme.bodySmall!.copyWith(
        fontWeight: FontWeightHelper.bold,
      );
  TextStyle get styleRegular14 => textTheme.bodyMedium!;

  TextStyle get styleMedium14 => textTheme.labelMedium!;
  TextStyle get styleSemiBold14 => textTheme.labelLarge!.copyWith(
        fontWeight: FontWeightHelper.semiBold,
      );
  TextStyle get styleBold14 => textTheme.labelLarge!;

  TextStyle get styleExtraBold14 => textTheme.labelLarge!.copyWith(
        fontWeight: FontWeightHelper.extraBold,
      );

  TextStyle get styleRegular16 => textTheme.bodyLarge!;

  TextStyle get styleLight16 => textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeightHelper.light,
      );
  TextStyle get styleSemiBold16 => textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeightHelper.semiBold,
      );

  TextStyle get styleBold16 => textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeightHelper.bold,
      );

  TextStyle get styleExtraBold16 => textTheme.bodyLarge!.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.extraBold,
      );

  TextStyle get styleMedium18 => textTheme.titleMedium!;

  TextStyle get styleSemiBold18 => textTheme.headlineSmall!;
  TextStyle get styleRegular20 => textTheme.titleLarge!.copyWith(
        fontWeight: FontWeightHelper.regular,
      );
  TextStyle get styleBold20 => textTheme.titleLarge!;

  TextStyle get styleExtraBold20 => textTheme.headlineMedium!;

  TextStyle get styleExtraBold22 => textTheme.displaySmall!;

  TextStyle get styleBold24 => textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeightHelper.bold,
      );

  TextStyle get styleExtraBold24 => textTheme.headlineLarge!;

  TextStyle get styleBlack28 => textTheme.displayMedium!;
  TextStyle get styleBlack30 =>
      textTheme.displayMedium!.copyWith(fontSize: 30.sp);
  TextStyle get styleBold34 => textTheme.displayLarge!.copyWith(
        fontWeight: FontWeightHelper.bold,
      );

  TextStyle get styleBlack34 => textTheme.displayLarge!;
}
