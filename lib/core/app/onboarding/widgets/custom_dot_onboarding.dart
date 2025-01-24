import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
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
      padding: context.padding(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          OnboardingInfo.onboardingInfo.length,
          (index) {
            return Container(
              height: context.setH(8),
              width: currentIndex == index
                  ? (context.isLandscape ? context.setW(30) : context.setW(50))
                  : (context.isLandscape ? context.setW(10) : context.setW(20)),
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.setR(20)),
                color: currentIndex == index
                    ? context.colors.primary
                    : context.colors.primary.withAlpha(90),
              ),
            );
          },
        ),
      ),
    );
  }
}
