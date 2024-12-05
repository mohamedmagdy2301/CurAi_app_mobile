import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class ImageOnboarding extends StatelessWidget {
  const ImageOnboarding({
    required this.image,
    required this.state,
    super.key,
  });

  final String image;
  final OnboardingState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.isLandscape ? padding(horizontal: 25.w) : padding(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1.2),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          );
        },
        child: Image.asset(
          image,
          key: ValueKey<String>(image),
          height: 460.h,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
