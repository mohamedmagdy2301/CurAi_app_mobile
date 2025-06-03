import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoReviewsWidget extends StatelessWidget {
  const NoReviewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (context.H * 0.02).hSpace,
        Icon(
          CupertinoIcons.star_slash_fill,
          size: 150.sp,
          color: context.onSecondaryColor.withAlpha(40),
        ),
        10.hSpace,
        SizedBox(
          width: context.W * 0.8,
          child: AutoSizeText(
            context.isStateArabic
                ? 'لا توجد تقييمات بعد'
                : 'No DoctorReviews Yet',
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.extraBold34().copyWith(
              color: context.onSecondaryColor.withAlpha(40),
            ),
          ),
        ),
        8.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'سيكون لديك الفرصة لتقييم الطبيب بعد الانتهاء من الاستشارة'
              : 'You will have the opportunity to rate the doctor after the consultation is over',
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular18().copyWith(
            color: context.onSecondaryColor.withAlpha(60),
          ),
        ).paddingSymmetric(horizontal: context.W * 0.1),
      ],
    ).center();
  }
}
