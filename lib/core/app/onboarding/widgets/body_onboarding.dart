import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/widgets/custom_dot_onboarding.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_button.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

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
      height: 320.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      padding: padding(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            context.translate(title),
            style: context.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeightHelper.black,
            ),
          ),
          spaceHeight(15),
          Padding(
            padding: padding(horizontal: 20, vertical: 10),
            child: Text(
              textAlign: TextAlign.center,
              context.translate(body),
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeightHelper.medium,
                color: context.colors.bodyOnboarding!.withOpacity(.5),
              ),
            ),
          ),
          CustomDotOnboarding(
            index: index,
            currentIndex: currentIndex,
          ),
          const Spacer(),
          CustemButton(
            title: LangKeys.next,
            onPressed: () {
              context.read<OnboardingCubit>().nextPage();
              if (BlocProvider.of<OnboardingCubit>(context).state
                  is OnboardingFinished) {
                context.pushReplacementNamed(Routes.testone);
              }
            },
          ),
        ],
      ),
    );
  }
}