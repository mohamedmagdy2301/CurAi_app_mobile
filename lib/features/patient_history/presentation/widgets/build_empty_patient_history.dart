import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildEmptyPatientHistory extends StatelessWidget {
  const BuildEmptyPatientHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.history_rounded,
          size: 150.sp,
          color: context.onSecondaryColor.withAlpha(80),
        ),
        20.hSpace,
        Text(
          context.translate(LangKeys.noHistory),
          style: TextStyleApp.medium26().copyWith(
            color: context.onSecondaryColor.withAlpha(100),
          ),
        ),
        12.hSpace,
        Text(
          context.translate(LangKeys.noHistoryDescription),
          style: TextStyleApp.regular14().copyWith(
            color: context.onSecondaryColor.withAlpha(100),
          ),
        ),
        50.hSpace,
      ],
    ).center();
  }
}
