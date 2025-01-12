import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class NotHaveAccount extends StatelessWidget {
  const NotHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.translate(LangKeys.notHaveAccount),
          style: context.textTheme.bodyMedium!.copyWith(
              // color: context.colors.textColorLight,
              ),
        ),
        TextButton(
          onPressed: () => context.pushNamed(Routes.registerScreen),
          child: Text(
            context.translate(LangKeys.register),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeightHelper.extraBold,
            ),
          ),
        ),
      ],
    );
  }
}
