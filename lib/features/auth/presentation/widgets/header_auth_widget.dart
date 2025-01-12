import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:flutter/material.dart';

class HeaderAuthWidger extends StatelessWidget {
  const HeaderAuthWidger({
    required this.title,
    required this.descraption,
    super.key,
  });
  final String title;
  final String descraption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceHeight(40),
        AutoSizeText(
          context.translate(title),
          style: context.styleBold24.copyWith(
            color: context.color.primary,
          ),
          maxLines: 1,
        ),
        spaceHeight(10),
        AutoSizeText(
          context.translate(descraption),
          style: context.styleRegular14.copyWith(
            color: context.color.onSecondary,
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
