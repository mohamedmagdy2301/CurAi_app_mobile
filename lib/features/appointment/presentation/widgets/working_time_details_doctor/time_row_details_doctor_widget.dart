import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class TimeRowWidget extends StatelessWidget {
  const TimeRowWidget({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isWork,
    super.key,
  });
  final bool? isWork;
  final String startTime;
  final String endTime;
  final String day;

  @override
  Widget build(BuildContext context) {
    if (isWork ?? true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            context.translate(day),
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium16().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
          AutoSizeText(
            '$startTime ${context.translate(LangKeys.am)}   :   $endTime ${context.translate(LangKeys.pm)}',
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.regular14().copyWith(
              color: context.onPrimaryColor.withAlpha(140),
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 3);
    } else {
      return const SizedBox();
    }
  }
}
