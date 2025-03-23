import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class HeaderAuthWidget extends StatelessWidget {
  const HeaderAuthWidget({
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
        40.hSpace,
        AutoSizeText(
          context.translate(title),
          style: TextStyleApp.bold24().copyWith(
            color: context.primaryColor,
          ),
          maxLines: 1,
        ),
        10.hSpace,
        AutoSizeText(
          context.translate(descraption),
          style: TextStyleApp.regular14().copyWith(
            color: context.onSecondaryColor,
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
