import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateingDoctorWidget extends StatelessWidget {
  const RateingDoctorWidget({
    required this.doctorModel,
    super.key,
  });

  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3.w,
      children: [
        Icon(CupertinoIcons.star_fill, color: Colors.amber, size: 18.sp),
        SizedBox(
          width: context.W * .07,
          child: AutoSizeText(
            context.isStateArabic ? doctorModel.ratingAr : doctorModel.ratingEn,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
