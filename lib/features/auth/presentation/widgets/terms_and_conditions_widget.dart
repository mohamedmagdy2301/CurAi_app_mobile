import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class TermsOfServiceWidget extends StatelessWidget {
  const TermsOfServiceWidget({
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
            style: TextStyleApp.regular14().copyWith(
              color: context.onSecondaryColor,
            ),
            maxLines: 1,
          ),
          5.wSpace,
          InkWell(
            onTap: () => context.pushNamed(Routes.privacyPolicyScreen),
            child: AutoSizeText(
              context.translate(LangKeys.termsOfUse),
              style: TextStyleApp.semiBold14().copyWith(
                color: context.primaryColor,
              ),
              maxLines: 1,
            ),
          ),
          5.wSpace,
          AutoSizeText(
            context.translate(LangKeys.and),
            style: TextStyleApp.regular14().copyWith(
              color: context.onSecondaryColor,
            ),
            maxLines: 1,
          ),
          5.wSpace,
          InkWell(
            onTap: () => context.pushNamed(Routes.privacyPolicyScreen),
            child: AutoSizeText(
              context.translate(LangKeys.privacyPolicy),
              style: TextStyleApp.semiBold14().copyWith(
                color: context.primaryColor,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 20);
  }
}
