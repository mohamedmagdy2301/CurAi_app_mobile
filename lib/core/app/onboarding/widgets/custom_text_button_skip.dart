import 'package:curai_app_mobile/core/app/onboarding/cubit/onboarding_cubit.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextButtonSkip extends StatelessWidget {
  const CustomTextButtonSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<OnboardingCubit>().skip();
        context.pushReplacementNamed(Routes.mainScaffoldUser);
      },
      child: Text(
        context.translate(LangKeys.skip),
        style: context.textTheme.bodyLarge!.copyWith(
            // color: context.colors.bodyTextOnboarding,
            ),
      ),
    );
  }
}
