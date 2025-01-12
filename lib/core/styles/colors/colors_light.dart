import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';

const lightPalettes = {
  ColorsPalleteState.green: ThemePaletteModel(
    primary: Colors.green, // Primary color reflecting health
    secondary: Colors.blue, // Secondary color for trust and stability
    tertiary: Colors.blueGrey, // Tertiary color for calm and neutrality
    background: Color(0xFFECECEC), // Light background color
    backgroundLight: Color(0xFFF5F5F5), // Light shade for subtle contrast
    error: Color(0xFFE53935), // Error color
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Color.fromARGB(255, 98, 98, 98), // Text on secondary color
    onTertiary: Colors.white, // Text on tertiary color
    onSurface: Colors.black, // Surface text color
    onError: Colors.white, // Error text color
  ),
  ColorsPalleteState.blue: ThemePaletteModel(
    primary: Colors.blue, // Primary color for trust
    secondary: Colors.greenAccent, // Secondary color for health
    tertiary: Colors.blueGrey, // Tertiary color for calm and neutrality
    background: Color(0xFFECECEC), // Background color
    backgroundLight: Color(0xFFF5F5F5), // Lighter background
    error: Color(0xFFE53935), // Error color
    onPrimary: Colors.white, // On primary text
    onSecondary: Color.fromARGB(255, 98, 98, 98), // Text on secondary color
    onTertiary: Colors.white, // On tertiary text
    onSurface: Colors.black, // On surface text
    onError: Colors.white, // On error text
  ),
};

// const lightPalettes = {
//   ColorsPalleteState.orange: ThemePaletteModel(
//     primary: Colors.orange,
//     secondary: Colors.orangeAccent,
//     tertiary: Colors.deepOrange,
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.blue: ThemePaletteModel(
//     primary: Colors.blue,
//     secondary: Colors.blueAccent,
//     tertiary: Colors.blueGrey,
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.green: ThemePaletteModel(
//     primary: Colors.green,
//     secondary: Colors.greenAccent,
//     tertiary: Color.fromARGB(255, 25, 74, 26),
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.red: ThemePaletteModel(
//     primary: Colors.red,
//     secondary: Colors.redAccent,
//     tertiary: Color.fromARGB(255, 107, 28, 22),
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.indigo: ThemePaletteModel(
//     primary: Colors.indigo,
//     secondary: Colors.indigoAccent,
//     tertiary: Colors.deepPurple,
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
//   ColorsPalleteState.purple: ThemePaletteModel(
//     primary: Colors.purple,
//     secondary: Colors.purpleAccent,
//     tertiary: Colors.deepPurple,
//     background: Color(0xFFECECEC),
//     backgroundLight: Color(0xFFF5F5F5),
//     text: Color(0xFF2D2D2D),
//     error: Color(0xFFE53935),
//     onPrimary: Colors.white,
//     onSecondary: Colors.black,
//     onTertiary: Colors.white,
//     onSurface: Color(0xFF2D2D2D),
//     onError: Colors.white,
//   ),
// };
