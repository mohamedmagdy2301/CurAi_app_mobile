import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class AleadyHaveAccount extends StatelessWidget {
  const AleadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          context.translate(LangKeys.alreadyHaveAccount),
          style: context.styleRegular14.copyWith(
            color: context.color.onSecondary,
          ),
          maxLines: 1,
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: AutoSizeText(
            context.translate(LangKeys.login),
            style: context.styleSemiBold14.copyWith(
              color: context.color.primary,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
