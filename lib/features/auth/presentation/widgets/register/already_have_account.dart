import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
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
