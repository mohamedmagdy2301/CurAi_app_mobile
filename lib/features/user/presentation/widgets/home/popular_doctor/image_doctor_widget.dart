import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
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
            context.isStateArabic ? 12 : 2,
          ),
          bottomRight: Radius.circular(
            context.isStateArabic ? 12 : 2,
          ),
          bottomLeft: Radius.circular(
            context.isStateArabic ? 2 : 12,
          ),
          topLeft: Radius.circular(
            context.isStateArabic ? 2 : 12,
          ),
        ),
        child: Hero(
          tag: doctorModel.id.toString(),
          child: Image.asset(
            doctorModel.imageUrl,
            height: 130,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
