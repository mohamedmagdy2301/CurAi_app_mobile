import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/get_day_of_week_format.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:flutter/material.dart';

class TimeRowWidget extends StatefulWidget {
  const TimeRowWidget({
    required this.doctorAvailability,
    super.key,
  });
  final DoctorPatientAvailability doctorAvailability;

  @override
  State<TimeRowWidget> createState() => _TimeRowWidgetState();
}

class _TimeRowWidgetState extends State<TimeRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.W * 0.3,
              child: AutoSizeText(
                getDayOfWeekFormat(
                  day: widget.doctorAvailability.day ?? '',
                  isArabic: context.isStateArabic,
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium16().copyWith(
                  color: context.onSecondaryColor,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: context.W * 0.14,
              child: AutoSizeText(
                widget.doctorAvailability.availableFrom!
                    .toLocalizedTime(context),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium16().copyWith(
                  color: context.onPrimaryColor.withAlpha(140),
                ),
              ),
            ),
            8.wSpace,
            AutoSizeText(
              ':',
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.onPrimaryColor.withAlpha(140),
              ),
            ),
            8.wSpace,
            SizedBox(
              width: context.W * 0.14,
              child: AutoSizeText(
                widget.doctorAvailability.availableTo!.toLocalizedTime(context),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium14().copyWith(
                  color: context.onPrimaryColor.withAlpha(140),
                ),
              ),
            ),
          ],
        ),
        5.hSpace,
        Divider(
          color: context.onSecondaryColor.withAlpha(80),
          thickness: .3,
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
