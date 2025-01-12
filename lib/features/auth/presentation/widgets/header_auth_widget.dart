import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
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
        spaceHeight(30),
        Text(
          context.translate(title),
          style: context.textTheme.headlineLarge!.copyWith(
            color: context.colors.primaryColor,
            fontWeight: FontWeightHelper.extraBold,
          ),
        ),
        spaceHeight(10),
        Text(
          context.translate(descraption),
          style: context.textTheme.bodyMedium!.copyWith(
              // color: context.colors.textColorLight,
              ),
        ),
      ],
    );
  }
}
