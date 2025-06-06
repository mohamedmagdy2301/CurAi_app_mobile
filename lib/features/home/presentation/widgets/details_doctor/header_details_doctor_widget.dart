// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/image_viewer_full_screen.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
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
        InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            showImageViewerFullScreen(
              context,
              imageUrl:
                  doctorResults.profilePicture ?? AppImages.avatarOnlineDoctor,
            );
          },
          child: CustomCachedNetworkImage(
            imgUrl:
                doctorResults.profilePicture ?? AppImages.avatarOnlineDoctor,
            width: context.H * 0.15,
            height: context.H * 0.19,
            loadingImgPadding: 60.sp,
            errorIconSize: 60.sp,
          ).cornerRadiusWithClipRRect(20.r),
        ),
        10.wSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.hSpace,
            AutoSizeText(
              '${context.translate(LangKeys.dr)} '
              "${doctorResults.firstName?.capitalizeFirstChar ?? ""} "
              "${doctorResults.lastName?.capitalizeFirstChar ?? ""}",
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.extraBold26().copyWith(
                color: context.onPrimaryColor,
              ),
            ).withWidth(context.W * .55),
            3.hSpace,
            DoctorDetailsHeader(doctorResults: doctorResults)
                .withWidth(context.W * .55),
          ],
        ).withHeight(context.H * 0.22),
      ],
    );
  }
}

class DoctorDetailsHeader extends StatelessWidget {
  const DoctorDetailsHeader({required this.doctorResults, super.key});
  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    final infoWidgets = <Widget>[];

    if (doctorResults.bio != null) {
      return InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {
          AdaptiveDialogs.showOkAlertDialog(
            context: context,
            title: context.translate(LangKeys.bio),
            onPressed: () => context.pop(),
            message: SingleChildScrollView(
              child: Text(
                doctorResults.bio!,
                textDirection: doctorResults.bio!.isArabicFormat
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyleApp.medium18().copyWith(
                  color: context.onSecondaryColor,
                ),
              ),
            ),
          );
        },
        child: AutoSizeText(
          doctorResults.bio!,
          maxLines: 4,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          minFontSize: 16,
          textDirection: doctorResults.bio!.isArabicFormat
              ? TextDirection.rtl
              : TextDirection.ltr,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      );
    }

    if (doctorResults.specialization != null) {
      infoWidgets.add(
        Wrap(
          children: [
            AutoSizeText(
              '${context.translate(LangKeys.specialty)}: ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium18().copyWith(
                color: context.onPrimaryColor.withAlpha(180),
              ),
            ),
            AutoSizeText(
              specializationName(
                doctorResults.specialization,
                isArabic: context.isStateArabic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    if (doctorResults.consultationPrice != null) {
      infoWidgets.add(
        Wrap(
          children: [
            AutoSizeText(
              '${context.translate(LangKeys.consultationPrice)}: ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium18().copyWith(
                color: context.onPrimaryColor.withAlpha(180),
              ),
            ),
            AutoSizeText(
              '${context.isStateArabic ? toArabicNumber(doctorResults.consultationPrice!.split('.')[0]) : doctorResults.consultationPrice!.split('.')[0]} '
              '${context.translate(LangKeys.egp)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.medium16().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return infoWidgets.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: infoWidgets,
          )
        : const SizedBox();
  }
}
