import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class CustomDotOnboarding extends StatelessWidget {
  const CustomDotOnboarding({
    required this.index,
    required this.currentIndex,
    super.key,
  });
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          OnboardingInfo.onboardingInfo.length,
          (index) {
            return Container(
              height: 8,
              width: currentIndex == index
                  ? (context.isLandscape ? 30 : 50)
                  : (context.isLandscape ? 10 : 20),
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentIndex == index
                    ? context.backgroundColor
                    : context.backgroundColor.withAlpha(90),
              ),
            );
          },
        ),
      ),
    );
  }
}
