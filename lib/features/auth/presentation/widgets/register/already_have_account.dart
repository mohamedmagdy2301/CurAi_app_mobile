import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          context.translate(LangKeys.alreadyHaveAccount),
          style: TextStyleApp.regular16().copyWith(
            color: context.onSecondaryColor,
          ),
          maxLines: 1,
        ),
        TextButton(
          onPressed: () => context.pushNamed(Routes.loginScreen),
          child: AutoSizeText(
            context.translate(LangKeys.login),
            style: TextStyleApp.semiBold16().copyWith(
              color: context.primaryColor,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
