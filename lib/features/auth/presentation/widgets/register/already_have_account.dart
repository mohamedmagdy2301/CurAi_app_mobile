import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

class AleadyHaveAccount extends StatelessWidget {
  const AleadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.translate(LangKeys.alreadyHaveAccount),
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.colors.textColorLight,
          ),
        ),
        TextButton(
          onPressed: () => context.pushReplacementNamed(Routes.loginScreen),
          child: Text(
            context.translate(LangKeys.login),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primaryColor,
              fontWeight: FontWeightHelper.extraBold,
            ),
          ),
        ),
      ],
    );
  }
}
