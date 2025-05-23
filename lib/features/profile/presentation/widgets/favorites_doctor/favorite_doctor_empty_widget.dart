// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteDoctorEmptyWidget extends StatefulWidget {
  const FavoriteDoctorEmptyWidget({super.key});

  @override
  State<FavoriteDoctorEmptyWidget> createState() =>
      _FavoriteDoctorEmptyWidgetState();
}

class _FavoriteDoctorEmptyWidgetState extends State<FavoriteDoctorEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.heart_slash,
            size: 180.sp,
            color: context.onSecondaryColor.withAlpha(80),
          ),
          28.hSpace,
          AutoSizeText(
            context.isStateArabic
                ? 'لا يوجد اي طبيب في قائمة المفضلة'
                : 'No doctor in favorite list',
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold26().copyWith(
              color: context.onSecondaryColor.withAlpha(90),
            ),
          ).paddingSymmetric(horizontal: 20),
        ],
      ),
    );
  }
}
