import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';

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
            context.translate(LangKeys.byLogging),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.textColorLight,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.termsOfUse),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primaryColor,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.and),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.textColorLight,
            ),
          ),
          spaceWidth(5),
          Text(
            context.translate(LangKeys.privacyPolicy),
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
