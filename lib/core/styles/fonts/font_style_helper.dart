import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/fonts_family_helper.dart';

class AppTextStyles {
  static TextStyle bodyLarge({required Color color}) => TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle bodyMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle bodySmall({required Color color}) => TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle titleLarge({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 20,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle titleMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 18,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );

  static TextStyle appBarTitle({required Color color}) => TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 22,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(),
      );
}
