import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAppointmentsPatientEmptyList extends StatelessWidget {
  const BuildAppointmentsPatientEmptyList({required this.isPending, super.key});
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          CupertinoIcons.calendar_badge_plus,
          size: 180.sp,
          color: context.onSecondaryColor.withAlpha(120),
        ),
        30.hSpace,
        AutoSizeText(
          isPending
              ? context.isStateArabic
                  ? 'لا يوجد مواعيد حالياً,\nقيد الانتظار'
                  : 'No Appointments yet,\nPending'
              : context.isStateArabic
                  ? 'لا يوجد مواعيد حالياً,\nمدفوعة'
                  : 'No Appointments yet,\nPaided',
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.semiBold26().copyWith(
            color: context.onSecondaryColor.withAlpha(120),
          ),
        ),
        30.hSpace,
      ],
    ).center();
  }
}
