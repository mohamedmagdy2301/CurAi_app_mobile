import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreahHeader extends StatelessWidget {
  const CustomRefreahHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
      waterDropColor: context.primaryColor,
      refresh: const CustomLoadingWidget().paddingSymmetric(vertical: 10),
      // idleIcon: Icon(
      //   CupertinoIcons.arrow_down,
      //   color: Colors.white,
      //   size: 20.sp,
      // ),
      failed: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          10.wSpace,
          Text(
            context.isStateArabic ? 'فشل التحديث' : 'Refresh failed',
            style: TextStyleApp.regular14().copyWith(color: Colors.red),
          ),
        ],
      ),
      complete: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.done, color: Colors.green),
          10.wSpace,
          Text(
            context.isStateArabic ? 'تم التحديث' : 'Refresh completed',
            style: TextStyleApp.regular14().copyWith(color: Colors.green),
          ),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
