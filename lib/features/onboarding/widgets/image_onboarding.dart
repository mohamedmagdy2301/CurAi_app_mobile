import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/onboarding/cubit/onboarding_cubit.dart';
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
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
            ),
          );

          final scaleAnimation = Tween<double>(
            begin: 0.95,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
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
