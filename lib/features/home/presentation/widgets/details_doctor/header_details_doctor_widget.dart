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
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/social_contact_doctor_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

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

class ConsultationPriceWidget extends StatelessWidget {
  const ConsultationPriceWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.consultationPrice),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        5.hSpace,
        AutoSizeText(
          '${doctorResults.consultationPrice} '
          '${context.translate(LangKeys.egp)}',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class MedicalDegreeWidget extends StatelessWidget {
  const MedicalDegreeWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.medicalSpecialization),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold18().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        5.hSpace,
        AutoSizeText(
          ' ${specializationName(
            doctorResults.specialization ?? '',
            isArabic: context.isStateArabic,
          )} ',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          context.translate(LangKeys.aboutMe),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        10.hSpace,
        ReadMoreText(
          doctorResults.bio ?? context.translate(LangKeys.noBio),
          trimLines: 3,
          colorClickableText: Theme.of(context).colorScheme.primary,
          trimMode: TrimMode.Line,
          trimCollapsedText: context.isStateArabic ? 'عرض الكل' : 'Show All',
          trimExpandedText: context.isStateArabic ? 'إخفاء' : 'Show Less',
          textAlign: TextAlign.start,
          locale:
              context.isStateArabic ? const Locale('ar') : const Locale('en'),
          textDirection:
              (doctorResults.bio ?? context.translate(LangKeys.noBio))
                      .isArabicFormat
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
          moreStyle: TextStyleApp.medium16().copyWith(
            color: context.onPrimaryColor,
          ),
          lessStyle: TextStyleApp.medium16().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class ExpandableBioText extends StatefulWidget {
  const ExpandableBioText({
    required this.bio,
    required this.isArabic,
    super.key,
  });
  final String bio;
  final bool isArabic;

  @override
  State<ExpandableBioText> createState() => _ExpandableBioTextState();
}

class _ExpandableBioTextState extends State<ExpandableBioText> {
  @override
  Widget build(BuildContext context) {
    final textDirection =
        widget.bio.isArabicFormat ? TextDirection.rtl : TextDirection.ltr;

    return ReadMoreText(
      widget.bio,
      trimLines: 3,
      colorClickableText: Theme.of(context).colorScheme.primary,
      trimMode: TrimMode.Line,
      trimCollapsedText: widget.isArabic ? 'عرض الكل' : 'Show All',
      trimExpandedText: widget.isArabic ? 'إخفاء' : 'Show Less',
      textAlign: TextAlign.start,
      locale: context.isStateArabic ? const Locale('ar') : const Locale('en'),
      textDirection: textDirection,
      style: TextStyleApp.medium18().copyWith(
        color: context.onSecondaryColor,
      ),
      moreStyle: TextStyleApp.medium16().copyWith(
        color: context.onPrimaryColor,
      ),
      lessStyle: TextStyleApp.medium16().copyWith(
        color: context.onPrimaryColor,
      ),
    );
  }
}
