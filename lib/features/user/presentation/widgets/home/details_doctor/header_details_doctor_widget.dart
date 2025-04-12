import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/specialization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderDetailsDoctorWidget extends StatelessWidget {
  const HeaderDetailsDoctorWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(1000.r),
          child: CustomCachedNetworkImage(
            imgUrl: doctorResults.profilePicture ??
                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            width: context.isTablet ? context.H * 0.18 : context.H * 0.155,
            height: context.isTablet ? context.H * 0.18 : context.H * 0.155,
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
              width: context.W * .5,
              child: AutoSizeText(
                doctorResults.username ?? '',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.extraBold24().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
            SizedBox(
              width: context.W * .35,
              child: AutoSizeText(
                '${context.translate(LangKeys.specialty)} ${specializationName(
                  doctorResults.specialization ?? '',
                  context.isStateArabic,
                )} ',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium14().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
            SizedBox(
              width: context.W * .33,
              child: AutoSizeText(
                '${doctorResults.consultationPrice} ${context.translate(LangKeys.egp)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.extraBold16().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
          ],
        )
            .withHeight(
              context.isTablet ? context.H * 0.18 : context.H * 0.155,
            )
            .paddingSymmetric(horizontal: 12, vertical: 5),
      ],
    );
  }
}
