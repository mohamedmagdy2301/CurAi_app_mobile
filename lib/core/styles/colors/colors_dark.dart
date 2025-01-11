import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';

const darkPalettes = {
  ColorsPalleteState.orange: ThemePaletteModel(
    primary: Colors.orange,
    secondary: Colors.orangeAccent,
    background: Color(0xFF121212),
    text: Color(0xFFBBDEFB),
    error: Color(0xFFEF5350),
  ),
  ColorsPalleteState.blue: ThemePaletteModel(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    background: Color(0xFF121212),
    text: Color(0xFFBBDEFB),
    error: Color(0xFFEF5350),
  ),
  ColorsPalleteState.green: ThemePaletteModel(
    primary: Colors.green,
    secondary: Colors.greenAccent,
    background: Color(0xFF121212),
    text: Color(0xFFC8E6C9),
    error: Color(0xFFEF5350),
  ),
  ColorsPalleteState.red: ThemePaletteModel(
    primary: Colors.red,
    secondary: Colors.redAccent,
    background: Color(0xFF121212),
    text: Color(0xFFFFCDD2),
    error: Color(0xFFEF5350),
  ),
  ColorsPalleteState.indigo: ThemePaletteModel(
    primary: Colors.indigo,
    secondary: Colors.indigoAccent,
    background: Color(0xFF121212),
    text: Color(0xFFFFCDD2),
    error: Color(0xFFEF5350),
  ),
  ColorsPalleteState.purple: ThemePaletteModel(
    primary: Colors.purple,
    secondary: Colors.purpleAccent,
    background: Color(0xFF121212), // Adjust as needed
    text: Color(0xFFD1C4E9), // Adjust as needed
    error: Color(0xFFEF5350), // Adjust as needed
  ),
};
