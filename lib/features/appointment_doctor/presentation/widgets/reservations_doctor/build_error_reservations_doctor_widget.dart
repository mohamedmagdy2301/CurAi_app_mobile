import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildErrorReservationsDoctorWidget extends StatelessWidget {
  const BuildErrorReservationsDoctorWidget({
    required this.message,
    super.key,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: context.onSecondaryColor.withAlpha(50),
          size: 160.sp,
        ),
        20.hSpace,
        AutoSizeText(
          message,
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
