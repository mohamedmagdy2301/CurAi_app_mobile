import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/widgets/body_onboarding.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/widgets/custom_text_button_skip.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/widgets/image_onboarding.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final onboardingInfo = OnboardingInfo.onboardingInfo[state.index];
            return Scaffold(
              // backgroundColor: context.colors.containerBG,
              body: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(context.assets.onboardingBG!),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      context.colors.onboardingBg!,
                      BlendMode.multiply,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.index == OnboardingInfo.onboardingInfo.length - 1)
                      spaceHeight(48)
                    else
                      const CustomTextButtonSkip(),
                    ImageOnboarding(
                      image: onboardingInfo.image,
                    ),
                  ],
                ),
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
