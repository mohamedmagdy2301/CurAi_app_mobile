import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    this.isLoading = false,
    this.isHalf = false,
    this.isNoLang = false,
    this.isRegular = false,
    super.key,
    this.onPressed,
    this.colorBackground,
    this.colorBorder,
    this.colorText,
    this.icon,
  });
  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  final bool isHalf;
  final bool isNoLang;
  final Color? colorBackground;
  final Color? colorBorder;
  final Color? colorText;
  final Widget? icon;
  final bool isRegular;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(
              colorBackground ?? context.primaryColor.withAlpha(220),
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: colorBorder ?? Colors.transparent,
              ),
            ),
          ),
      onPressed: onPressed,
      child: isLoading
          ? CustomLoadingWidget(
              width: 30.w,
              height: 30.h,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon! else const SizedBox.shrink(),
                if (icon != null) 6.wSpace else const SizedBox.shrink(),
                AutoSizeText(
                  isNoLang ? title : context.translate(title),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: isRegular
                      ? TextStyleApp.regular18().copyWith(
                          color: colorText ?? Colors.white,
                        )
                      : isHalf
                          ? TextStyleApp.medium16().copyWith(
                              color: colorText ?? Colors.white,
                            )
                          : TextStyleApp.bold18().copyWith(
                              color: colorText ?? Colors.white,
                            ),
                ),
              ],
            ),
    );
  }
}
