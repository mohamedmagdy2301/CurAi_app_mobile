import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAppointmentsPatientEmptyList extends StatelessWidget {
  const BuildAppointmentsPatientEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.event_busy, size: 80.sp, color: context.onSecondaryColor),
        16.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'لا يوجد مواعيد حالياً'
              : 'No Appointments yet',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.semiBold18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    ).center();
  }
}
