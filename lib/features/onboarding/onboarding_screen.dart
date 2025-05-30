import 'package:curai_app_mobile/core/styles/images/asset_preloader_helper.dart';
import 'package:curai_app_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/features/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/features/onboarding/widgets/body_onboarding.dart';
import 'package:curai_app_mobile/features/onboarding/widgets/image_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AssetImagePreloader.preloadAssetsOnboarding(context);
    });
  }

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
