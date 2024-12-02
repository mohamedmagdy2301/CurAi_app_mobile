import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/images/app_images.dart';

class MyAssets extends ThemeExtension<MyAssets> {
  const MyAssets({
    required this.testImageTheme,
    required this.onboardingBG,
  });

  final String? testImageTheme;
  final String? onboardingBG;

  @override
  ThemeExtension<MyAssets> copyWith({
    String? testImageTheme,
    String? onboardingBG,
  }) {
    return MyAssets(
      testImageTheme: testImageTheme,
      onboardingBG: onboardingBG,
    );
  }

  @override
  ThemeExtension<MyAssets> lerp(
    covariant ThemeExtension<MyAssets>? other,
    double t,
  ) {
    if (other is! MyAssets) {
      return this;
    }
    return MyAssets(
      testImageTheme: testImageTheme,
      onboardingBG: onboardingBG,
    );
  }

  static const MyAssets dark = MyAssets(
    testImageTheme: AppImages.testDark,
    onboardingBG: AppImages.onboardingBGDark,
  );
  static const MyAssets light = MyAssets(
    testImageTheme: AppImages.testLight,
    onboardingBG: AppImages.onboardingBGLight,
  );
}
