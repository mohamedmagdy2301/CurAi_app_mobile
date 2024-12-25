import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDoctorWidget extends StatelessWidget {
  const ImageDoctorWidget({
    required this.modelDoctor,
    super.key,
  });

  final DoctorModel modelDoctor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(isArabic() ? 12.r : 2.r),
        bottomRight: Radius.circular(isArabic() ? 12.r : 2.r),
        bottomLeft: Radius.circular(isArabic() ? 2.r : 12.r),
        topLeft: Radius.circular(isArabic() ? 2.r : 12.r),
      ),
      child: Image.asset(
        modelDoctor.imageUrl,
        height: 130.w,
        width: 90.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
