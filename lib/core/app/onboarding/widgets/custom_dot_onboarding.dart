import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

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
      padding: padding(vertical: 10),
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
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentIndex == index
                    ? context.colors.primaryColor
                    : context.colors.bodyTextOnboarding!.withOpacity(.4),
              ),
            );
          },
        ),
      ),
    );
  }
}
