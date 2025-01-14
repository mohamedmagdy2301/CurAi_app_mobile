// ignore_for_file: flutter_style_todos

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
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
          AutoSizeText(
            title,
            maxLines: 1,
            style: context.styleBold20,
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: AutoSizeText(
              context.translate(LangKeys.seeAll),
              style: context.styleBold14.copyWith(
                color: context.colors.primary,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
