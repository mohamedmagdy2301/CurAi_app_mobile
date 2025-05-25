import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialityItemWidget extends StatelessWidget {
  const DoctorSpecialityItemWidget({
    required this.title,
    required this.image,
    required this.specialityName,
    super.key,
    this.isLoading,
  });
  final String title;
  final String specialityName;
  final String image;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.allDoctors, arguments: specialityName);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10000.r),
            child: isLoading ?? false
                ? Icon(
                    Icons.error,
                    size: 65.sp,
                  )
                : CustomCachedNetworkImage(
                    imgUrl: image,
                    width: context.H * 0.08,
                    height: context.H * 0.08,
                    loadingImgPadding: 10.w,
                    errorIconSize: 50.sp,
                  ),
            // image.contains('.svg')
            //     ? SvgPicture.asset(
            //         image,
            //         height: 25.h,
            //         width: 25.w,
            //         fit: BoxFit.fill,
            //       )
            //     : Image.asset(
            //         image,
            //         height: 25.h,
            //         width: 25.w,
            //         fit: BoxFit.fill,
            //       ),
          ),
          10.hSpace,
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.regular12().copyWith(
              color: context.onPrimaryColor,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
