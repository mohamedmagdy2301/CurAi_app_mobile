import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/working_time_details_doctor/time_row_details_doctor_widget.dart';
import 'package:flutter/material.dart';

class WorkingTimeDetailsDoctorWidget extends StatelessWidget {
  const WorkingTimeDetailsDoctorWidget({
    required this.doctorAvailability,
    super.key,
  });
  final List<DoctorPatientAvailability> doctorAvailability;

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
        5.hSpace,
        Column(
          children: _buildUniqueDayWidgets(),
        ),
      ],
    );
  }

  List<Widget> _buildUniqueDayWidgets() {
    final seenDays = <String>{};
    final widgets = <Widget>[];

    final weekDaysOrder = [
      'SATURDAY',
      'SUNDAY',
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
    ];

    // ترتيب القائمة حسب ترتيب أيام الأسبوع
    final sortedList = doctorAvailability.toList()
      ..sort((a, b) {
        final dayA = a.day?.toUpperCase() ?? '';
        final dayB = b.day?.toUpperCase() ?? '';
        return weekDaysOrder
            .indexOf(dayA)
            .compareTo(weekDaysOrder.indexOf(dayB));
      });

    for (final date in sortedList) {
      final day = date.day?.toUpperCase() ?? '';
      if (!seenDays.contains(day)) {
        seenDays.add(day);
        widgets.add(TimeRowWidget(doctorAvailability: date));
      }
    }

    return widgets;
  }
}
