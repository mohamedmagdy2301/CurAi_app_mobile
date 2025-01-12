import 'package:flutter/material.dart';

class ThemePaletteModel {
  const ThemePaletteModel({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.backgroundLight,
    required this.text,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    required this.onSurface,
    required this.onError,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color backgroundLight;
  final Color text;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onTertiary;
  final Color onSurface;
  final Color onError;
}

List<Color> colorPalette = [
  Colors.blue,
  Colors.green,
];
