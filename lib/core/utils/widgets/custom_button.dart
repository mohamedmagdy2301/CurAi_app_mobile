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
    super.key,
    this.onPressed,
    this.color,
  });
  final String title;
  final void Function()? onPressed;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor:
                WidgetStatePropertyAll(color ?? context.primaryColor),
          ),
      onPressed: onPressed,
      child: isLoading
          ? CustomLoadingWidget(
              width: 30.w,
              height: 30.h,
            )
          : Text(
              context.translate(title),
              style: TextStyleApp.bold20().copyWith(
                color: Colors.white,
              ),
            ),
    );
  }
}
