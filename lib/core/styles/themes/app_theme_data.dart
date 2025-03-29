// ignore_for_file: avoid_positional_boolean_parameters

import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemeData {
  static ThemeData darkTheme(String fontFamily, Color seedColor) => ThemeData(
        fontFamily: fontFamily,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDarkColor,
        primaryColor: seedColor,
        colorScheme: _colorScheme(seedColor, Brightness.dark),
        iconTheme: const IconThemeData(color: AppColors.textDarkColor),
        bottomNavigationBarTheme:
            _bottomNavBarTheme(AppColors.backgroundDarkColor),
        appBarTheme: _appBarTheme(
          AppColors.textDarkColor,
          AppColors.backgroundDarkColor,
        ),
        inputDecorationTheme: _inputDecorationTheme(seedColor),
        cardTheme: _cardTheme(AppColors.backgroundDarkColor),
        elevatedButtonTheme: _elevatedButtonTheme(seedColor),
        snackBarTheme: _snackBarTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData lightTheme(String fontFamily, Color seedColor) => ThemeData(
        fontFamily: fontFamily,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLightColor,
        primaryColor: seedColor,
        colorScheme: _colorScheme(seedColor, Brightness.light),
        iconTheme: const IconThemeData(color: AppColors.textLightColor),
        bottomNavigationBarTheme:
            _bottomNavBarTheme(AppColors.backgroundLightColor),
        appBarTheme: _appBarTheme(
          AppColors.textLightColor,
          AppColors.backgroundLightColor,
        ),
        inputDecorationTheme: _inputDecorationTheme(seedColor),
        cardTheme: _cardTheme(AppColors.backgroundLightColor),
        elevatedButtonTheme: _elevatedButtonTheme(seedColor),
        snackBarTheme: _snackBarTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
  static SnackBarThemeData _snackBarTheme() {
    return SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
      ),
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }

  static ColorScheme _colorScheme(Color seedColor, Brightness brightness) =>
      ColorScheme.fromSeed(
        seedColor: seedColor,
        onPrimary: brightness == Brightness.dark
            ? AppColors.textDarkColor
            : AppColors.textLightColor,
        onSecondary: brightness == Brightness.dark
            ? AppColors.textSubDarkColor
            : AppColors.textSubLightColor,
        brightness: brightness,
      );

  static BottomNavigationBarThemeData _bottomNavBarTheme(
    Color backgroundColor,
  ) =>
      BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      );

  static AppBarTheme _appBarTheme(Color textColor, Color backgroundColor) =>
      AppBarTheme(
        titleTextStyle: TextStyleApp.bold20().copyWith(color: textColor),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      );

  static InputDecorationTheme _inputDecorationTheme(Color seedColor) =>
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: BorderSide(color: seedColor.withAlpha(80)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: BorderSide(color: seedColor.withAlpha(80)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: BorderSide(color: seedColor),
        ),
        errorStyle: TextStyleApp.medium14().copyWith(color: Colors.redAccent),
        labelStyle: TextStyleApp.medium14().copyWith(color: seedColor),
      );

  static CardTheme _cardTheme(Color backgroundColor) => CardTheme(
        color: backgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme(Color seedColor) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: seedColor,
          elevation: 0,
          alignment: Alignment.center,
          fixedSize: Size(800.w, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
}
