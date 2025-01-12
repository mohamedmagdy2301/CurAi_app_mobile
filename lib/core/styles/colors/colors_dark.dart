import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';

const darkPalettes = {
  ColorsPalleteState.green: ThemePaletteModel(
    primary: Colors.green, // Primary color reflecting health
    secondary: Colors.blue, // Secondary color for trust and stability
    tertiary: Colors.blueGrey, // Tertiary color for calm and neutrality
    background: Color(0xFF121212), // Dark background for dark mode
    backgroundLight: Color(0xFF303030), // Lighter dark background
    text: Color(0xFFBBDEFB), // Light text color for dark mode
    error: Color(0xFFEF5350), // Error color
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Colors.white, // Text on secondary color
    onTertiary: Colors.white, // Text on tertiary color
    onSurface: Color(0xFFBBDEFB), // Surface text color
    onError: Colors.white, // Error text color
  ),
  ColorsPalleteState.blue: ThemePaletteModel(
    primary: Colors.blue, // Primary color for trust
    secondary: Colors.greenAccent, // Secondary color for health
    tertiary: Colors.blueGrey, // Tertiary color for calm and neutrality
    background: Color(0xFF121212), // Dark background for dark mode
    backgroundLight: Color(0xFF303030), // Lighter dark background
    text: Color(0xFFBBDEFB), // Light text color for dark mode
    error: Color(0xFFEF5350), // Error color
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Colors.white, // Text on secondary color
    onTertiary: Colors.white, // Text on tertiary color
    onSurface: Color(0xFFBBDEFB), // Surface text color
    onError: Colors.white, // Error text color
  ),
};

// const darkPalettes = {
//   ColorsPalleteState.orange: ThemePaletteModel(
//     primary: Colors.orange,
//     secondary: Colors.orangeAccent,
//   tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.blue: ThemePaletteModel(
//     primary: Colors.blue,
//     secondary: Colors.blueAccent,
//   tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.green: ThemePaletteModel(
//     primary: Colors.green,
//     secondary: Colors.greenAccent,
//     tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.red: ThemePaletteModel(
//     primary: Colors.red,
//     secondary: Colors.redAccent,
//     tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.indigo: ThemePaletteModel(
//     primary: Colors.indigo,
//     secondary: Colors.indigoAccent,
//    tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.purple: ThemePaletteModel(
//     primary: Colors.purple,
//     secondary: Colors.purpleAccent,
//    tertiary: Colors.deepOrange,
//     background: Color(0xFF121212),
//     backgroundLight: Color(0xFF303030),
//     text: Color(0xFFBBDEFB),
//     error: Color(0xFFEF5350),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFFBBDEFB),
//     onError: Colors.white,
//   ),
// };
