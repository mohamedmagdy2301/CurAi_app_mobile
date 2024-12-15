// ignore_for_file: flutter_style_todos

import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({required this.title, super.key, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: context.textTheme.titleLarge!.copyWith(
              //TODO: change color
              color: context.colors.bodyTextOnboarding,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              context.translate(LangKeys.seeAll),
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.colors.primaryColor,
                fontWeight: FontWeightHelper.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
