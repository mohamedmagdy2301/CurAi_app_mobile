import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/home_widgets/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerEmergencyHomeWidget extends StatelessWidget {
  const BannerEmergencyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () => context.pushNamed(Routes.emergencyDepartment),
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: context.primaryColor.withAlpha(210),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -70.h,
                right: 100.w,
                bottom: -60.h,
                left: -40.w,
                child: CustomPaint(
                  size: Size(400.w, 200.h),
                  painter: RPSCustomPainter(context: context),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.backgroundColor,
                    child: Image.asset(
                      AppImages.emergency,
                      width: 22.h,
                      height: 22.h,
                      color: Colors.redAccent,
                      fit: BoxFit.fill,
                    ),
                  ),
                  10.wSpace,
                  SizedBox(
                    width: context.W * .62,
                    child: AutoSizeText(
                      context.translate(LangKeys.emergencyDepartment),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyleApp.bold22().copyWith(
                        color: context.backgroundColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.backgroundColor,
                    size: 20.sp,
                  ),
                ],
              ).paddingSymmetric(vertical: 15, horizontal: 10),
            ],
          ),
        ),
      ),
    );
  }
}
