// ignore_for_file: parameter_assignments, use_build_context_synchronously

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
import 'package:flutter_svg/flutter_svg.dart';

class AllDoctorEmptyWidget extends StatelessWidget {
  const AllDoctorEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          80.hSpace,
          SvgPicture.asset(
            AppImagesSvg.searchEmpty,
            width: 200.w,
            height: 200.h,
          ),
          40.hSpace,
          AutoSizeText(
            context.translate(LangKeys.noDoctorsFound),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyleApp.regular26().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
