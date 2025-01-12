import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
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
            style: context.styleSemiBold12.copyWith(
              color: context.color.onSecondary,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.termsOfUse),
            style: context.styleBold12.copyWith(
              color: context.color.primary,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.and),
            style: context.styleSemiBold12.copyWith(
              color: context.color.onSecondary,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.privacyPolicy),
            style: context.styleBold12.copyWith(
              color: context.color.primary,
            ),
          ),
        ],
      ),
    );
  }
}
