import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:smartcare_app_mobile/core/styles/colors/colors_light.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.mainColor,
  });

  final Color? mainColor;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? mainColor,
  }) {
    return MyColors(
      mainColor: mainColor,
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
      mainColor: mainColor,
    );
  }

  static MyColors dark = const MyColors(
    mainColor: ColorsDark.primaryColor,
  );

  static MyColors light = const MyColors(
    mainColor: ColorsLight.primaryColor,
  );
}
