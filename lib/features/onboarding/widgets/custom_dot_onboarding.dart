import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/onboarding/data/onboarding_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              height: 8.h,
              width: currentIndex == index
                  ? (context.isLandscape ? 30.w : 50.w)
                  : (context.isLandscape ? 10.w : 20.w),
              margin: EdgeInsets.only(right: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: currentIndex == index
                    ? context.primaryColor
                    : context.primaryColor.withAlpha(100),
              ),
            );
          },
        ),
      ),
    );
  }
}
