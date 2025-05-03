// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingTimeDoctorCardWidget extends StatelessWidget {
  const WorkingTimeDoctorCardWidget({required this.items, super.key});
  final List<WorkingTimeDoctorAvailableModel> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: context.padding(vertical: 10),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      color: context.isDark
          ? Colors.black45
          : const Color.fromARGB(255, 232, 232, 232),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.calendar_today,
                  color: context.primaryColor.withAlpha(160),
                  size: 26.sp,
                ).paddingSymmetric(vertical: 4),
                8.wSpace,
                SizedBox(
                  width: context.W * .72,
                  child: Wrap(
                    children: [
                      AutoSizeText(
                        '${context.translate(
                          items.length == 1 ? LangKeys.day : LangKeys.days,
                        )} ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleApp.medium18().copyWith(
                          color: context.onPrimaryColor,
                        ),
                      ),
                      for (int i = 0; i < items.length; i++)
                        AutoSizeText(
                          '${items[i].getLocalizedDays(isArabic: context.isStateArabic).join(', ')}'
                          '${i != items.length - 1 ? "${i != items.length - 2 ? "," : " ${context.translate(LangKeys.and)}"} " : ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.medium18().copyWith(
                            color: context.onPrimaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 30.h,
              thickness: .2,
              color: context.onSecondaryColor.withAlpha(120),
            ),
          ],
        ),
        subtitle: Wrap(
          children: [
            AutoSizeText(
              '${context.translate(LangKeys.workStartTimeFrom)} ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.regular16().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
            AutoSizeText(
              '${items.first.availableFrom?.toLocalizedTime(context)} ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.primaryColor,
              ),
            ),
            AutoSizeText(
              '${context.translate(LangKeys.to)} ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.regular16().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
            AutoSizeText(
              '${items.first.availableTo?.toLocalizedTime(context)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.primaryColor,
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 8, horizontal: 8),
      ),
    );
  }
}
