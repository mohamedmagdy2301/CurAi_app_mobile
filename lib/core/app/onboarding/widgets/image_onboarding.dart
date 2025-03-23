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
          : context.padding(),
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
          height: 460,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
