import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get W => size.width;

  double get H => size.height;

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get canPop => Navigator.canPop(this);

  void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

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

  bool get isDark => mode.isDark;

  // //! Padding symetric
  EdgeInsets padding({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );
  }
}
