import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
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
          AutoSizeText(
            context.translate(LangKeys.byLoggingIn),
            style: context.styleRegular14.copyWith(
              color: context.color.onSecondary,
            ),
            maxLines: 1,
          ),
          context.spaceWidth(5),
          AutoSizeText(
            context.translate(LangKeys.termsOfUse),
            style: context.styleSemiBold14.copyWith(
              color: context.color.primary,
            ),
            maxLines: 1,
          ),
          context.spaceWidth(5),
          AutoSizeText(
            context.translate(LangKeys.and),
            style: context.styleRegular14.copyWith(
              color: context.color.onSecondary,
            ),
            maxLines: 1,
          ),
          context.spaceWidth(5),
          AutoSizeText(
            context.translate(LangKeys.privacyPolicy),
            style: context.styleSemiBold14.copyWith(
              color: context.color.primary,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
