import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLoadingPatientHistory extends StatelessWidget {
  const BuildLoadingPatientHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomLoadingWidget(height: 40.h, width: 40.w),
        24.hSpace,
        AutoSizeText(
          context.translate(LangKeys.loading),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    ).center();
  }
}
