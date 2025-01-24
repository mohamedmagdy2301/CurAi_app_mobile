import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/details_doctor_screen.dart';
import 'package:flutter/material.dart';

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
          topRight: Radius.circular(
            context.isStateArabic ? context.setR(12) : context.setR(2),
          ),
          bottomRight: Radius.circular(
            context.isStateArabic ? context.setR(12) : context.setR(2),
          ),
          bottomLeft: Radius.circular(
            context.isStateArabic ? context.setR(2) : context.setR(12),
          ),
          topLeft: Radius.circular(
            context.isStateArabic ? context.setR(2) : context.setR(12),
          ),
        ),
        child: Hero(
          tag: doctorModel.id.toString(),
          child: Image.asset(
            doctorModel.imageUrl,
            height: context.setH(130),
            width: context.setW(90),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
