import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDoctorWidget extends StatelessWidget {
  const ImageDoctorWidget({
    required this.doctorResults,
    super.key,
    this.isLoading,
  });

  final DoctorInfoModel doctorResults;
  final bool? isLoading;

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
      child: isLoading ?? false
          ? Container(
              width: context.W * 0.25,
              height: context.isTablet ? context.H * 0.18 : context.H * 0.155,
              color: context.onSecondaryColor,
            )
          : CustomCachedNetworkImage(
              imgUrl:
                  doctorResults.profilePicture ?? AppImages.avatarOnlineDoctor,
              width: context.W * 0.25,
              height: context.isTablet ? context.H * 0.18 : context.H * 0.16,
              loadingImgPadding: 50.w,
              errorIconSize: 50.sp,
            ),
    );
  }
}
