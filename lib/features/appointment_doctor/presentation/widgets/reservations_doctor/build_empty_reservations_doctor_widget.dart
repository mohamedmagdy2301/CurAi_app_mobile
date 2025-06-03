import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildEmptyReservationsDoctorWidget extends StatelessWidget {
  const BuildEmptyReservationsDoctorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: context.onSecondaryColor.withAlpha(50),
          size: 160.sp,
        ),
        20.hSpace,
        AutoSizeText(
          context.translate(LangKeys.noReservations),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium28().copyWith(
            color: context.onSecondaryColor.withAlpha(80),
          ),
        ).paddingSymmetric(horizontal: 40.w),
      ],
    ).center();
  }
}
