import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateDoctorWidget extends StatelessWidget {
  const DateDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.isStateArabic ? modelDoctor.dateAr : modelDoctor.dateEn,
          style: context.textTheme.labelSmall!.copyWith(
            // color: context.colors.bodyTextOnboarding,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
        RateingDoctorWidget(modelDoctor: modelDoctor),
      ],
    );
  }
}
