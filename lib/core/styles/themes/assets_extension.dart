import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/styles/images/app_images.dart';

class MyAssets extends ThemeExtension<MyAssets> {
  const MyAssets({
    required this.testImageTheme,
  });

  final String? testImageTheme;

  @override
  ThemeExtension<MyAssets> copyWith({
    String? testImageTheme,
  }) {
    return MyAssets(
      testImageTheme: testImageTheme,
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
    );
  }

  static const MyAssets dark = MyAssets(
    testImageTheme: AppImages.testDark,
  );
  static const MyAssets light = MyAssets(
    testImageTheme: AppImages.testLight,
  );
}
