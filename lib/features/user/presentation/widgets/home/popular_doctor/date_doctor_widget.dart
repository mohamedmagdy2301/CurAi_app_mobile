import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';

class DateDoctorWidget extends StatelessWidget {
  const DateDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.isStateArabic ? modelDoctor.dateAr : modelDoctor.dateEn,
          style: TextStyleApp.regular14().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        RateingDoctorWidget(modelDoctor: modelDoctor),
      ],
    );
  }
}
