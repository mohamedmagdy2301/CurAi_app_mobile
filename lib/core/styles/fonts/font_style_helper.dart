import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/fonts_family_helper.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle bodyLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );

  static TextStyle bodyMedium(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );

  static TextStyle bodySmall(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );

  static TextStyle titleLarge(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 20,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );

  static TextStyle titleMedium(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontSize: 18,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );

  static TextStyle appBarTitle(BuildContext context, {required Color color}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeightHelper.bold,
        fontSize: 22,
        fontFamily: FontsFamilyHelper.getLocaledFontFamily(context),
      );
}
