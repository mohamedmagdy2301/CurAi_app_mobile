import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/asset_preloader_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/features/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/features/onboarding/widgets/custom_dot_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyOnboarding extends StatelessWidget {
  const BodyOnboarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final onboardingInfo = OnboardingInfo.onboardingInfo[state.index];
        return Container(
          height: context.H * 0.46,
          width: context.W,
          decoration: BoxDecoration(
            color: context.primaryColor.withAlpha(10),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          padding: context.padding(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: context.H * 0.12,
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  context.translate(onboardingInfo.title),
                  maxLines: 2,
                  style: TextStyleApp.bold34().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: context.H * 0.17,
                child: AutoSizeText(
                  context.translate(onboardingInfo.body),
                  style: TextStyleApp.medium20().copyWith(
                    color: context.onSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ).paddingSymmetric(horizontal: 6),
              ),
              CustomDotOnboarding(
                index: onboardingInfo.index,
                currentIndex: state.index,
              ),
              CustomButton(
                title: onboardingInfo.index ==
                        OnboardingInfo.onboardingInfo.length - 1
                    ? LangKeys.getStarted
                    : LangKeys.next,
                onPressed: () {
                  context.read<OnboardingCubit>().nextPage();
                  if (BlocProvider.of<OnboardingCubit>(context).state
                      is OnboardingFinished) {
                    AssetImagePreloader.removeOnboardingImagesFromCache();
                    di.sl<CacheDataManager>().setData(
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
    );
  }
}
