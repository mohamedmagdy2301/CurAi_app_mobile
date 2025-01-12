import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
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
          style: context.styleSemiBold12.copyWith(
            color: context.color.onSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.pushNamed(Routes.registerScreen),
          child: Text(
            context.translate(LangKeys.register),
            style: context.styleBold12.copyWith(
              color: context.color.primary,
            ),
          ),
        ),
      ],
    );
  }
}
