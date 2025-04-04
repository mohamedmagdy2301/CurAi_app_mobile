import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/body_onboarding.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/image_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final onboardingInfo = OnboardingInfo.onboardingInfo[state.index];
            return ImageOnboarding(
              image: onboardingInfo.image,
              state: state,
            );
          },
        ),
        bottomSheet: const BodyOnboarding(),
      ),
    );
  }
}
