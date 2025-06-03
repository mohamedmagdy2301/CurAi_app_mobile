import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/details_doctor/location_tap/doctor_maps_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationTap extends StatelessWidget {
  const LocationTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocationWidget(doctorResults: doctorResults),
        10.hSpace,
        if (doctorResults.location != null && doctorResults.latitude != null)
          DoctorMapsWidget(doctorResults: doctorResults)
              .withHeight(context.H * .4)
        else
          Column(
            children: [
              Icon(
                CupertinoIcons.location_slash_fill,
                color: context.onSecondaryColor.withAlpha(100),
                size: 120.sp,
              ),
              50.hSpace,
              AutoSizeText(
                context.translate(LangKeys.doctorNotHaveLocationInfoMaps),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.medium22().copyWith(
                  color: context.onSecondaryColor,
                ),
              ).center().paddingSymmetric(horizontal: 20),
            ],
          ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hSpace,
        AutoSizeText(
          context.translate(LangKeys.locationMe),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.bold20().copyWith(
            color: context.onPrimaryColor.withAlpha(180),
          ),
        ),
        10.hSpace,
        AutoSizeText(
          doctorResults.location?.capitalizeFirstChar ?? '',
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium20().copyWith(
            color: context.onSecondaryColor,
          ),
        ).withHeight(context.H * .1),
      ],
    );
  }
}
