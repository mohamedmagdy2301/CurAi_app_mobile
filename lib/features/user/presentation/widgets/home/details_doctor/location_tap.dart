import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/details_doctor/doctor_maps_widget.dart';
import 'package:flutter/material.dart';

class LocationTap extends StatelessWidget {
  const LocationTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocationWidget(doctorResults: doctorResults),
        10.hSpace,
        SizedBox(
          height: context.H * .36,
          child: DoctorMapsWidget(doctorResults: doctorResults),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.locationMe),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        10.hSpace,
        SizedBox(
          height: context.H * .1,
          child: AutoSizeText(
            // doctorResults.location ?? '',
            context.isStateArabic
                ? 'مصر, القاهرة, مدينة نصر, مدينة 6 أكتوبر, شارع الأزهر, 1234'
                : 'Eygpt, Cairo, Nasr City, 6th of October City, Al-Azhar Street, 1234',
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium20().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
