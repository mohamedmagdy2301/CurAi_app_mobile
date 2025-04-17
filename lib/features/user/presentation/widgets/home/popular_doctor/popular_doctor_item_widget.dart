import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/screens/details_doctor_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/image_doctor_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorItemWidget extends StatelessWidget {
  const PopularDoctorItemWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.push(DoctorDetailsScreen(doctorResults: doctorResults)),
      borderRadius: BorderRadius.circular(10.r),
      child: Card(
        elevation: 1,
        shadowColor: context.onSecondaryColor.withAlpha(70),
        shape: RoundedRectangleBorder(
          side: const BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ImageDoctorWidget(doctorResults: doctorResults),
            Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.W * .55,
                  child: AutoSizeText(
                    '${context.translate(LangKeys.dr)} '
                    '${doctorResults.firstName?.capitalizeFirstChar ?? ''} '
                    '${doctorResults.lastName?.capitalizeFirstChar ?? ''}',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.extraBold24().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                if (doctorResults.specialization != '')
                  Row(
                    children: [
                      SizedBox(
                        width: context.W * .55,
                        child: AutoSizeText(
                          specializationName(
                            doctorResults.specialization ?? '',
                            context.isStateArabic,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.bold16().copyWith(
                            color: context.onPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (doctorResults.consultationPrice != '')
                  SizedBox(
                    width: context.W * .55,
                    child: AutoSizeText(
                      '${doctorResults.consultationPrice} '
                      '${context.translate(LangKeys.egp)}',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleApp.bold16().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                  ),
                RateingDoctorWidget(doctorResults: doctorResults),
              ],
            ).paddingSymmetric(horizontal: 12, vertical: 5),
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: 18, vertical: 3);
  }
}
