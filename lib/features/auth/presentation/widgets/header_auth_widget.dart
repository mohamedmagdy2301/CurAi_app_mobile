import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAuthWidget extends StatelessWidget {
  const HeaderAuthWidget({
    required this.title,
    this.descraption,
    this.isBack = false,
    super.key,
  });
  final String title;
  final String? descraption;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.hSpace,
        Row(
          children: [
            AutoSizeText(
              context.translate(title),
              style: TextStyleApp.bold28().copyWith(
                color: context.primaryColor,
              ),
              maxLines: 1,
            ),
            const Spacer(),
            if (isBack)
              RotatedBox(
                quarterTurns: 2,
                child: BackButton(
                  color: context.primaryColor,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      context.primaryColor.withAlpha(60),
                    ),
                    overlayColor: WidgetStatePropertyAll(
                      context.primaryColor.withAlpha(140),
                    ),
                    alignment: Alignment.center,
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: context.onSecondaryColor,
                        width: .1.w,
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(
                      context.W > 400 ? Size(30.r, 30.r) : Size(16.r, 16.r),
                    ),
                    shape: const WidgetStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        10.hSpace,
        if (descraption != null)
          AutoSizeText(
            context.translate(descraption!),
            style: TextStyleApp.regular16().copyWith(
              color: context.onSecondaryColor,
            ),
            maxLines: 2,
          ),
      ],
    );
  }
}
