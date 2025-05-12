import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

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
      padding: context.isLandscape
          ? context.padding(horizontal: 25)
          : context.W > 460
              ? context.padding(horizontal: 25)
              : context.padding(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );
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
          height: context.H - (context.H * 0.4),
          width: context.W,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
