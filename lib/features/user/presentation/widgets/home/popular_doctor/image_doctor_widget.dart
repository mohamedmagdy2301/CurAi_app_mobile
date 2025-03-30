import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(
          context.isStateArabic ? 8.r : 2.r,
        ),
        bottomRight: Radius.circular(
          context.isStateArabic ? 8.r : 2.r,
        ),
        bottomLeft: Radius.circular(
          context.isStateArabic ? 2.r : 8.r,
        ),
        topLeft: Radius.circular(
          context.isStateArabic ? 2.r : 8.r,
        ),
      ),
      child: CustomCachedNetworkImage(
        imgUrl:
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        width: context.W * 0.25,
        height: context.isTablet ? context.H * 0.18 : context.H * 0.155,
        loadingImgPadding: 50.w,
        errorIconSize: 50.sp,
      ),
      // Image.asset(
      //   doctorModel.imageUrl,
      //   height: context.isTablet ? context.H * 0.18 : context.H * 0.155,
      //   width: context.W * 0.25,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
