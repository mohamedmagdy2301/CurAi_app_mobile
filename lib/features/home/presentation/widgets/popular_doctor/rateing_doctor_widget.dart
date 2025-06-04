import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateingDoctorWidget extends StatefulWidget {
  const RateingDoctorWidget({
    required this.doctorResults,
    super.key,
    this.isToAppointmentScreen = false,
  });

  final DoctorInfoModel doctorResults;
  final bool isToAppointmentScreen;

  @override
  State<RateingDoctorWidget> createState() => _RateingDoctorWidgetState();
}

class _RateingDoctorWidgetState extends State<RateingDoctorWidget> {
  double _avarageRateingDoctor() {
    double avarageRateing = 0;
    for (var i = 0; i < widget.doctorResults.reviews!.length; i++) {
      avarageRateing += widget.doctorResults.reviews![i].rating ?? 0;
    }
    return avarageRateing / widget.doctorResults.reviews!.length;
  }

  @override
  Widget build(BuildContext context) {
    return widget.doctorResults.reviews!.isEmpty
        ? Row(
            children: [
              StarRating(
                size: 20.r,
                color: Colors.orangeAccent,
                mainAxisAlignment: MainAxisAlignment.end,
                filledIcon: CupertinoIcons.star_fill,
                emptyIcon: CupertinoIcons.star,
                borderColor: context.onSecondaryColor.withAlpha(50),
              ),
              8.wSpace,
              AutoSizeText(
                context.isStateArabic ? 'لا يوجد تقييمات' : 'No Reviews',
                style: TextStyleApp.regular14().copyWith(
                  color: context.onSecondaryColor.withAlpha(100),
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ).withWidth(context.W * .22),
            ],
          )
        : Row(
            spacing: 3.w,
            children: [
              if (widget.isToAppointmentScreen == true)
                Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.orangeAccent,
                  size: 20.r,
                )
              else
                StarRating(
                  rating: _avarageRateingDoctor(),
                  size: 20.r,
                  color: Colors.orangeAccent,
                  mainAxisAlignment: MainAxisAlignment.end,
                  filledIcon: CupertinoIcons.star_fill,
                  emptyIcon: CupertinoIcons.star,
                  borderColor: context.onSecondaryColor.withAlpha(50),
                ),
              4.wSpace,
              AutoSizeText(
                _avarageRateingDoctor().toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.bold14().copyWith(
                  color: context.onPrimaryColor,
                ),
              ).withWidth(context.W * .07),
              AutoSizeText(
                '(${widget.doctorResults.reviews!.length} '
                '${context.translate(LangKeys.reviews)})',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium14().copyWith(
                  color: context.onSecondaryColor.withAlpha(100),
                ),
              ).withWidth(context.W * .22),
            ],
          );
  }
}
