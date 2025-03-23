import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';

class RateingDoctorWidget extends StatelessWidget {
  const RateingDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 15),
        Text(
          context.isStateArabic ? modelDoctor.ratingAr : modelDoctor.ratingEn,
          style: TextStyleApp.bold12().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
      ],
    );
  }
}
