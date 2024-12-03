import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.primaryColor,
    required this.textColorLight,
    required this.onboardingBg,
    required this.bodyTextOnboarding,
  });

  final Color? primaryColor;
  final Color? textColorLight;
  final Color? onboardingBg;
  final Color? bodyTextOnboarding;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? primaryColor,
    Color? textColorLight,
    Color? onboardingBg,
    Color? bodyOnboarding,
  }) {
    return MyColors(
      primaryColor: primaryColor,
      textColorLight: textColorLight,
      onboardingBg: onboardingBg,
      bodyTextOnboarding: bodyOnboarding,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      primaryColor: primaryColor,
      textColorLight: textColorLight,
      onboardingBg: onboardingBg,
      bodyTextOnboarding: bodyTextOnboarding,
    );
  }

  static MyColors dark = const MyColors(
    primaryColor: ColorsDark.primaryColor,
    textColorLight: ColorsLight.textColorLight,
    onboardingBg: Color.fromARGB(223, 42, 42, 42),
    bodyTextOnboarding: ColorsDark.textColor,
  );

  static MyColors light = const MyColors(
    primaryColor: ColorsLight.primaryColor,
    textColorLight: ColorsLight.textColorLight,
    onboardingBg: Color.fromARGB(158, 210, 210, 210),
    bodyTextOnboarding: ColorsLight.textColor,
  );
}
