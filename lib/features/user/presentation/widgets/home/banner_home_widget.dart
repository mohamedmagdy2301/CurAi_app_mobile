import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/RPSCustomPainter.dart';
import 'package:flutter/material.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding(horizontal: 20, vertical: 5),
      child: Container(
        height: 174,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.backgroundColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: 20,
              bottom: -50,
              left: 20,
              child: CustomPaint(
                size: const Size(
                  400,
                  200,
                ),
                painter: RPSCustomPainter(context: context),
              ),
            ),
            Positioned(
              top: 10,
              right: context.isStateArabic ? null : 10,
              bottom: 0,
              left: context.isStateArabic ? 10 : null,
              child: Image.asset(
                AppImages.doctorInBanner,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 15,
              right: context.isStateArabic ? 18 : null,
              bottom: 10,
              left: context.isStateArabic ? null : 18,
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    context.translate(LangKeys.bannerBookHome),
                    style: TextStyleApp.bold16().copyWith(
                      height: 1.6,
                      fontSize: context.isStateArabic ? 20 : 18,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 43,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: context.primaryColor.withAlpha(120),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      context.translate(LangKeys.findNearby),
                      textAlign: TextAlign.center,
                      style: TextStyleApp.semiBold14().copyWith(
                        color: context.backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
