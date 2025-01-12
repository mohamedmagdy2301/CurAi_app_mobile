import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            context.translate(LangKeys.byLoggingIn),
            style: context.textTheme.bodyMedium!.copyWith(
                // color: context.colors.textColorLight,
                ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.termsOfUse),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeightHelper.extraBold,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.and),
            style: context.textTheme.bodyMedium!.copyWith(
                // color: context.colors.textColorLight,
                ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.privacyPolicy),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeightHelper.extraBold,
            ),
          ),
        ],
      ),
    );
  }
}
