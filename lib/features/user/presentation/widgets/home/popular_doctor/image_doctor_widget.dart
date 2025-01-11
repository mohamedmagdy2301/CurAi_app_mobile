import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/details_doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDoctorWidget extends StatelessWidget {
  const ImageDoctorWidget({
    required this.doctorModel,
    super.key,
  });

  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(DoctorDetailsScreen(doctorModel: doctorModel)),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(context.isStateArabic ? 12.r : 2.r),
          bottomRight: Radius.circular(context.isStateArabic ? 12.r : 2.r),
          bottomLeft: Radius.circular(context.isStateArabic ? 2.r : 12.r),
          topLeft: Radius.circular(context.isStateArabic ? 2.r : 12.r),
        ),
        child: Hero(
          tag: doctorModel.id.toString(),
          child: Image.asset(
            doctorModel.imageUrl,
            height: 130.w,
            width: 90.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
