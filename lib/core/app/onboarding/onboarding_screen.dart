import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/body_onboarding.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/image_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: BlocProvider(
        create: (_) => OnboardingCubit(),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final onboardingInfo = OnboardingInfo.onboardingInfo[state.index];
            return Scaffold(
              body: ImageOnboarding(
                image: onboardingInfo.image,
                state: state,
              ),
              bottomSheet: BodyOnboarding(
                title: onboardingInfo.title,
                body: onboardingInfo.body,
                currentIndex: state.index,
                index: onboardingInfo.index,
              ),
            );
          },
        ),
      ),
    );
  }
}
