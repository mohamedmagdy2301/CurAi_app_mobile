// ignore_for_file: flutter_style_todos

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({required this.title, super.key, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          title,
          maxLines: 1,
          style: TextStyleApp.bold20().copyWith(
            color: context.primaryColor,
          ),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: onPressed,
          child: AutoSizeText(
            context.translate(LangKeys.seeAll),
            style: TextStyleApp.medium12().copyWith(
              color: context.primaryColor,
            ),
            maxLines: 1,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 15);
  }
}
