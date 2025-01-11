import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

//TODO: change color
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
          // backgroundColor: context.colors.iconSocialBG!.withOpacity(.6),
          radius: 26.r,
          child: image.contains('.svg')
              ? SvgPicture.asset(
                  image,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  image,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.fill,
                ),
        ),
        spaceHeight(15),
        Text(
          context.translate(title),
          style: context.textTheme.bodySmall!.copyWith(
              // color: context.colors.bodyTextOnboarding,
              ),
        ),
      ],
    );
  }
}
