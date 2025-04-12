import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';

class DateDoctorWidget extends StatelessWidget {
  const DateDoctorWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.W * .45,
          child: AutoSizeText(
            specializationName(
              doctorResults.specialization ?? '',
              context.isStateArabic,
            ),
            // doctorResults.specialization ?? '',
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
        ),
        RateingDoctorWidget(doctorResults: doctorResults),
      ],
    );
  }
}
