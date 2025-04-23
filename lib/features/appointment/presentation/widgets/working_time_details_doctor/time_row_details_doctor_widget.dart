import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:flutter/material.dart';

class TimeRowWidget extends StatelessWidget {
  const TimeRowWidget({
    required this.doctorAvailability,
    super.key,
  });
  final DoctorAvailability doctorAvailability;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          doctorAvailability.day ?? '',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
        AutoSizeText(
          '${doctorAvailability.availableFrom}   :   ${doctorAvailability.availableTo}',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular14().copyWith(
            color: context.onPrimaryColor.withAlpha(140),
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 3);
  }
}
