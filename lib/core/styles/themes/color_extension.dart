import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.primaryColor,
    required this.containerBG,
    // required this.titleOnboarding,
    required this.bodyOnboarding,
  });

  final Color? primaryColor;
  final Color? containerBG;
  // final Color? titleOnboarding;
  final Color? bodyOnboarding;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? primaryColor,
    Color? containerBG,
    // Color? titleOnboarding,
    Color? bodyOnboarding,
  }) {
    return MyColors(
      primaryColor: primaryColor,
      containerBG: containerBG,
      // titleOnboarding: titleOnboarding,
      bodyOnboarding: bodyOnboarding,
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
      containerBG: containerBG,
      // titleOnboarding: titleOnboarding,
      bodyOnboarding: bodyOnboarding,
    );
  }

  static MyColors dark = const MyColors(
    primaryColor: ColorsDark.primaryColor,
    containerBG: Color.fromARGB(255, 45, 45, 45),
    // titleOnboarding: ColorsDark.textColor,
    bodyOnboarding: ColorsDark.textColor,
  );

  static MyColors light = const MyColors(
    primaryColor: ColorsLight.primaryColor,
    containerBG: Color.fromARGB(255, 220, 220, 220),
    // titleOnboarding: ColorsLight.textColor,
    bodyOnboarding: ColorsLight.textColor,
  );
}
