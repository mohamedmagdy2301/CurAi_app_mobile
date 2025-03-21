import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/custom_dot_onboarding.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/responsive/size_provider.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyOnboarding extends StatelessWidget {
  const BodyOnboarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: Size(context.width, 330),
      height: context.setR(330),
      width: context.setR(context.width),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final onboardingInfo = OnboardingInfo.onboardingInfo[state.index];
          return Container(
            height: context.sizeProvider.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.color.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.setR(40)),
                topRight: Radius.circular(context.setR(40)),
              ),
            ),
            padding: context.padding(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                SizedBox(
                  height: context.setH(90),
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    context.translate(onboardingInfo.title),
                    maxLines: 2,
                    style: context.styleBold34,
                  ),
                ),
                SizedBox(
                  height: context.setH(90),
                  width: context.width * 0.9,
                  child: AutoSizeText(
                    context.translate(onboardingInfo.body),
                    style: context.styleMedium18.copyWith(
                      color: context.color.onSurface,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                ),
                const Spacer(),
                CustomDotOnboarding(
                  index: onboardingInfo.index,
                  currentIndex: state.index,
                ),
                const Spacer(),
                CustomButton(
                  title: onboardingInfo.index ==
                          OnboardingInfo.onboardingInfo.length - 1
                      ? LangKeys.getStarted
                      : LangKeys.next,
                  onPressed: () {
                    context.read<OnboardingCubit>().nextPage();
                    if (BlocProvider.of<OnboardingCubit>(context).state
                        is OnboardingFinished) {
                      SharedPrefManager.setData(
                        key: SharedPrefKey.keyIsFirstLaunch,
                        value: false,
                      );
                      context.pushReplacementNamed(Routes.loginScreen);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
