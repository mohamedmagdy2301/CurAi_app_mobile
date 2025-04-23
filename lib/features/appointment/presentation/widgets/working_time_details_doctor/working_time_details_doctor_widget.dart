import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/working_time_details_doctor/time_row_details_doctor_widget.dart';
import 'package:flutter/material.dart';

class WorkingTimeDetailsDoctorWidget extends StatelessWidget {
  const WorkingTimeDetailsDoctorWidget({
    required this.doctorAvailability,
    super.key,
  });
  final List<DoctorAvailability> doctorAvailability;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.workingTime),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        10.hSpace,
        Divider(
          color: context.onSecondaryColor.withAlpha(80),
          thickness: .3,
        ),
        const TimeRowWidget(
          day: LangKeys.saturday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.sunday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.monday,
          startTime: '10:00',
          endTime: '5:00',
          isWork: false,
        ),
        const TimeRowWidget(
          day: LangKeys.tuesday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.wednesday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.thursday,
          startTime: '10:00',
          endTime: '5:00',
        ),
        const TimeRowWidget(
          day: LangKeys.friday,
          startTime: '10:00',
          endTime: '5:00',
          isWork: false,
        ),
      ],
    );
  }
}
