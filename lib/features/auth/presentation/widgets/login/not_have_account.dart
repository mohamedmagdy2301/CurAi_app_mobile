import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
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
        AutoSizeText(
          context.translate(LangKeys.notHaveAccount),
          style: TextStyleApp.regular14().copyWith(
            color: context.onSecondaryColor,
          ),
          maxLines: 1,
        ),
        TextButton(
          onPressed: () => context.pushNamed(Routes.registerScreen),
          child: AutoSizeText(
            context.translate(LangKeys.register),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.semiBold14().copyWith(
              color: context.primaryColor,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: context.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
