import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_sizes_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/fonts_family_helper.dart';

class AppTextStyles {
  static TextStyle bodyLarge({
    required Color color,
    double fontSize = FontSizesHelper.large,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle bodySmall({
    required Color color,
    double fontSize = FontSizesHelper.small,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle titleSmall({
    required Color color,
    double fontSize = FontSizesHelper.medium,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle titleLarge({
    required Color color,
    double fontSize = FontSizesHelper.xxLarge,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle bodyMedium({
    required Color color,
    double fontSize = FontSizesHelper.medium,
  }) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle titleMedium({
    required Color color,
    double fontSize = FontSizesHelper.large,
  }) =>
      TextStyle(
        color: color.withOpacity(0.8),
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle appBarTitle({
    required Color color,
    double fontSize = FontSizesHelper.huge,
  }) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: fontSize,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );
}


//! Use it like this:
// Text(
//   'Welcome to SmartCare',
//   style: AppTextStyles.titleLarge(color: Colors.black),
// );

//! Use it like Custom Font Size:
// Text(
//   'Custom Font Size',
//   style: AppTextStyles.bodyMedium(
//     color: Colors.grey,
//     fontSize: FontSizes.xxLarge,
//   ),
// );
