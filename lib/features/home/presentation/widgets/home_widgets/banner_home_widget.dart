import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding(horizontal: 20, vertical: 5),
      child: Container(
        height: context.isStateArabic ? context.H * 0.185 : context.H * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: context.primaryColor.withAlpha(210),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50.h,
              right: 20.w,
              bottom: -50.h,
              left: 20.w,
              child: CustomPaint(
                size: Size(400.w, 200.h),
                painter: RPSCustomPainter(context: context),
              ),
            ),
            Positioned(
              right: context.isStateArabic ? null : 10.w,
              bottom: 0,
              width: context.W * 0.4,
              height: context.H * 0.1,
              left: context.isStateArabic ? 10.w : null,
              child: Image.asset(
                context.isStateArabic
                    ? AppImages.doctorInBanner
                    : AppImages.doctorInBanner2,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10.h,
              right: context.isStateArabic ? 18.w : null,
              left: context.isStateArabic ? null : 18.w,
              child: SizedBox(
                width: context.W * .8,
                height: context.H * 0.1,
                child: AutoSizeText(
                  context.translate(LangKeys.bannerBookHome),
                  style: TextStyleApp.semiBold24().copyWith(
                    height: 1.6,
                    color: context.backgroundColor,
                  ),
                ),
              ),
            ),
            Positioned(
              right: context.isStateArabic ? 18.w : null,
              bottom: 10.h,
              left: context.isStateArabic ? null : 18.w,
              child: InkWell(
                onTap: () => context.pushNamed(Routes.emergencyDepartment),
                child: Container(
                  width: context.W * 0.35,
                  height: context.H * 0.05,
                  padding: context.padding(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: context.backgroundColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    context.translate(LangKeys.toEmergency),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleApp.semiBold14().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
