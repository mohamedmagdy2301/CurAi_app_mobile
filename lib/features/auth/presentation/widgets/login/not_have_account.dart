import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';

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
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.colors.textColorLight,
          ),
        ),
        spaceWidth(5),
        Text(
          context.translate(LangKeys.login),
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.colors.primaryColor,
          ),
        ),
      ],
    );
  }
}
