import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationsDoctorDateHeader extends StatelessWidget {
  const ReservationsDoctorDateHeader({
    required this.date,
    required this.appointmentsCount,
    required this.isExpanded,
    super.key,
  });
  final String date;
  final int appointmentsCount;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor.withAlpha(140),
            context.primaryColor.withAlpha(180),
            context.primaryColor.withAlpha(220),
            context.primaryColor.withAlpha(250),
            context.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(isExpanded ? 0 : 16.r),
          bottomRight: Radius.circular(isExpanded ? 0 : 16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withAlpha(60),
            blurRadius: 12,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.backgroundColor.withAlpha(70),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          12.wSpace,
          AutoSizeText(
            date.toFullWithWeekdayTwoLine(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyleApp.medium16().copyWith(
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: context.padding(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.backgroundColor.withAlpha(60),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                AutoSizeText(
                  '$appointmentsCount ${context.translate(LangKeys.appointments)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyleApp.medium12().copyWith(color: Colors.white),
                ).withWidth(context.W * .18),
                4.wSpace,
                Icon(
                  isExpanded
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
