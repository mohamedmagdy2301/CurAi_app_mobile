// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/social_contact_doctor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderDetailsDoctorWidget extends StatelessWidget {
  const HeaderDetailsDoctorWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000.r),
          child: CustomCachedNetworkImage(
            imgUrl:
                doctorResults.profilePicture ?? AppImages.avatarOnlineDoctor,
            width: context.isTablet ? context.H * 0.17 : context.H * 0.145,
            height: context.isTablet ? context.H * 0.17 : context.H * 0.145,
            loadingImgPadding: 50.w,
            errorIconSize: 50.sp,
          ),
        ),
        5.wSpace,
        Column(
          spacing: 3.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.W * .55,
              child: AutoSizeText(
                '${context.translate(LangKeys.dr)} '
                "${doctorResults.firstName?.capitalizeFirstChar ?? ""} "
                "${doctorResults.lastName?.capitalizeFirstChar ?? ""}",
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.extraBold26().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
            10.hSpace,
            SocialContactDoctorWidget(doctorResults: doctorResults),
          ],
        )
            .withHeight(
              context.isTablet ? context.H * 0.19 : context.H * 0.15,
            )
            .paddingSymmetric(horizontal: 12, vertical: 5),
      ],
    );
  }
}
