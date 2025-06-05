import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BuildEmptyScheduleWidget extends StatelessWidget {
  const BuildEmptyScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImagesSvg.calendar,
          width: 200.w,
          height: 200.h,
          colorFilter: ColorFilter.mode(
            context.onSecondaryColor.withAlpha(50),
            BlendMode.srcIn,
          ),
        ),
        20.hSpace,
        AutoSizeText(
          context.translate(LangKeys.noAvailability),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium28().copyWith(
            color: context.onSecondaryColor.withAlpha(100),
          ),
        ),
        40.hSpace,
      ],
    );
  }
}
