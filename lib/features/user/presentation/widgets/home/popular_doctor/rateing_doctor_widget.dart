import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateingDoctorWidget extends StatelessWidget {
  const RateingDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Icon(Icons.star, color: Colors.amber, size: 15.sp),
        Text(
          context.isStateArabic ? modelDoctor.ratingAr : modelDoctor.ratingEn,
          style: context.textTheme.labelSmall!.copyWith(
            // color: context.colors.bodyTextOnboarding,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
      ],
    );
  }
}
