import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemeData {
  static const String fontFamilyEn = 'Poppins';
  static const String fontFamilyAr = 'Cairo';

  static ThemeData darkTheme(bool isStateArabic, Color seedColor) => ThemeData(
        fontFamily: isStateArabic ? fontFamilyAr : fontFamilyEn,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDarkColor,
        primaryColor: seedColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          onPrimary: AppColors.textDarkColor,
          onSecondary: AppColors.textSubDarkColor,
          brightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textDarkColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundDarkColor,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyleApp.bold20().copyWith(
            color: AppColors.textDarkColor,
          ),
          backgroundColor: AppColors.backgroundDarkColor,
          foregroundColor: AppColors.textDarkColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.textDarkColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: seedColor.withAlpha(120)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: seedColor.withAlpha(120)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: seedColor),
          ),
          errorStyle: TextStyleApp.medium14().copyWith(color: Colors.redAccent),
          labelStyle: TextStyleApp.medium14().copyWith(
            color: AppColors.textSubDarkColor,
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.backgroundDarkColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: seedColor,
            elevation: 0,
            fixedSize: Size(800.w, 50.h),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData lightTheme(bool isStateArabic, Color seedColor) => ThemeData(
        fontFamily: isStateArabic ? fontFamilyAr : fontFamilyEn,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLightColor,
        primaryColor: seedColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          onPrimary: AppColors.textLightColor,
          onSecondary: AppColors.textSubLightColor,
        ),
        iconTheme: const IconThemeData(color: AppColors.textLightColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundLightColor,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyleApp.bold20().copyWith(
            color: AppColors.textLightColor,
          ),
          backgroundColor: AppColors.backgroundLightColor,
          foregroundColor: AppColors.textLightColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.textLightColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(color: seedColor.withAlpha(120)),
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
            borderSide: BorderSide(color: seedColor.withAlpha(120)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(color: seedColor),
          ),
          errorStyle: TextStyleApp.medium14().copyWith(color: Colors.redAccent),
          labelStyle: TextStyleApp.medium14().copyWith(
            color: AppColors.textSubLightColor,
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.backgroundLightColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: seedColor,
            elevation: 0,
            fixedSize: Size(800.w, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
