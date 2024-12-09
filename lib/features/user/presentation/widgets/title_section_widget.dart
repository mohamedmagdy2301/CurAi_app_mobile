import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

class TitleSectionWidget extends StatelessWidget {
  const TitleSectionWidget({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: context.textTheme.titleLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          const Spacer(),
          Text(
            context.translate(LangKeys.seeAll),
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colors.primaryColor,
              fontWeight: FontWeightHelper.medium,
            ),
          ),
        ],
      ),
    );
  }
}
