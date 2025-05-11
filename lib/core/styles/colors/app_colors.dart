import 'package:flutter/material.dart';

class AppColors {
  // static const Color primary = Color.fromARGB(255, 112, 166, 178);
  static const Color primary = Color.fromARGB(255, 48, 151, 214);
  static const Color secondary = Colors.lightBlueAccent;
  static const Color backgroundLightColor = Color(0xffF1F1F1);
  static const Color backgroundDarkColor = Color(0xff161616);
  static const Color textLightColor = Color(0xff161616);
  static const Color textDarkColor = Color(0xffF1F1F1);
  static const Color textSubLightColor = Color.fromARGB(129, 22, 22, 22);
  static const Color textSubDarkColor = Color.fromARGB(121, 241, 241, 241);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
}

final List<Color> darkColors = [
  AppColors.primary,
  const Color.fromARGB(255, 99, 136, 3),
  const Color.fromARGB(255, 195, 107, 107),
  const Color(0xFF838073),
  const Color.fromARGB(255, 159, 162, 214),
];

final List<Color> lightColors = [
  AppColors.primary,
  const Color.fromARGB(255, 43, 123, 244),
  const Color.fromARGB(255, 99, 136, 3),
  const Color(0xFFc66e59),
  const Color(0xFF496878),
  const Color.fromARGB(255, 120, 115, 73),
  const Color(0xFF14213D),
];
