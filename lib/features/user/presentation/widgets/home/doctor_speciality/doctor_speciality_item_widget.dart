import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialityItemWidget extends StatelessWidget {
  const DoctorSpecialityItemWidget({
    required this.title,
    required this.image,
    super.key,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: context.onSecondaryColor.withAlpha(30),
          radius: context.H * 0.055,
          child: CustomCachedNetworkImage(
            imgUrl: image,
            width: context.H * 0.05,
            height: context.H * 0.05,
            loadingImgPadding: 7.w,
            errorIconSize: 20.sp,
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
          context.translate(title),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular12().copyWith(
            color: context.onPrimaryColor,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
