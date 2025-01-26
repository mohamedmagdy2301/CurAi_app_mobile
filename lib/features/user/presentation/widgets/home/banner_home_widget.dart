import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/RPSCustomPainter.dart';
import 'package:flutter/material.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding(horizontal: 20, vertical: 5),
      child: Container(
        height: context.setH(174),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setR(20)),
          color: context.color.primary,
        ),
        child: Stack(
          children: [
            Positioned(
              top: context.setH(-50),
              right: context.setW(20),
              bottom: context.setH(-50),
              left: context.setW(20),
              child: CustomPaint(
                size: Size(
                  context.setW(400),
                  context.setH(200),
                ),
                painter: RPSCustomPainter(context: context),
              ),
            ),
            Positioned(
              top: context.setH(10),
              right: context.isStateArabic ? null : context.setW(10),
              bottom: context.setH(0),
              left: context.isStateArabic ? context.setW(10) : null,
              child: Image.asset(
                AppImages.doctorInBanner,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: context.setH(15),
              right: context.isStateArabic ? context.setW(18) : null,
              bottom: context.setH(10),
              left: context.isStateArabic ? null : context.setW(18),
              width: context.setW(150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    context.translate(LangKeys.bannerBookHome),
                    style: context.styleBold16.copyWith(
                      height: 1.6,
                      fontSize: context.isStateArabic
                          ? context.setSp(20)
                          : context.setSp(18),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: context.setH(43),
                    width: context.setW(130),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.setR(50)),
                      color: context.color.onPrimary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      context.translate(LangKeys.findNearby),
                      textAlign: TextAlign.center,
                      style: context.styleSemiBold14.copyWith(
                        color: context.color.primary,
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
