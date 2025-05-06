import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  EdgeInsets get paddingOf => MediaQuery.paddingOf(this);

  double get W => size.width;

  double get H => size.height;

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isTablet => W > 600;

  bool get isPortrait => orientation == Orientation.portrait;

  //! App Theme Data
  ThemeData get theme => AdaptiveTheme.of(this).theme;
  Color get primaryColor => AdaptiveTheme.of(this).theme.primaryColor;
  Color get onPrimaryColor =>
      AdaptiveTheme.of(this).theme.colorScheme.onPrimary;
  Color get onSecondaryColor =>
      AdaptiveTheme.of(this).theme.colorScheme.onSecondary;
  Color get backgroundColor =>
      AdaptiveTheme.of(this).theme.scaffoldBackgroundColor;

  AdaptiveThemeMode get mode => AdaptiveTheme.of(this).mode;

  bool get isDark {
    if (mode == AdaptiveThemeMode.system) {
      final brightness = MediaQuery.of(this).platformBrightness;
      return brightness == Brightness.dark;
    }
    return mode == AdaptiveThemeMode.dark;
  }

  // //! Padding symetric
  EdgeInsets padding({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal?.w ?? 0,
      vertical: vertical?.h ?? 0,
    );
  }
}
