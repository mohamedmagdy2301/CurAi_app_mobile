import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/app/onboarding/data/onboarding_info.dart';
import 'package:curai_app_mobile/core/app/onboarding/widgets/custom_dot_onboarding.dart';
import 'package:curai_app_mobile/core/common/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyOnboarding extends StatelessWidget {
  const BodyOnboarding({
    required this.title,
    required this.body,
    required this.index,
    required this.currentIndex,
    super.key,
  });
  final int index;
  final int currentIndex;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      padding: padding(horizontal: 20, vertical: 25),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
            child: AutoSizeText(
              textAlign: TextAlign.center,
              context.translate(title),
              maxLines: 2,
              style: context.styleBold34,
            ),
          ),
          spaceHeight(10),
          SizedBox(
            height: 90.h,
            child: AutoSizeText(
              textAlign: TextAlign.center,
              context.translate(body),
              maxLines: 4,
              style: context.styleLight16,
            ),
          ),
          const Spacer(),
          CustomDotOnboarding(
            index: index,
            currentIndex: currentIndex,
          ),
          const Spacer(),
          CustemButton(
            title: index == OnboardingInfo.onboardingInfo.length - 1
                ? LangKeys.getStarted
                : LangKeys.next,
            onPressed: () {
              context.read<OnboardingCubit>().nextPage();
              if (BlocProvider.of<OnboardingCubit>(context).state
                  is OnboardingFinished) {
                context.pushReplacementNamed(Routes.loginScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}
