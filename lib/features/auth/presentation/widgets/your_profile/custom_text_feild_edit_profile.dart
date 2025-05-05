import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFeildEditProfile extends StatelessWidget {
  const CustomTextFeildEditProfile({
    required this.controller,
    required this.title,
    super.key,
    this.onChanged,
    this.keyboardType,
    this.maxLenght,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String title;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLenght;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate(title),
          style: TextStyleApp.medium14().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        8.hSpace,
        TextFormField(
          cursorColor: context.primaryColor,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          validator: (value) {
            if (value == '') {
              return '${context.translate(title)} '
                  '${context.translate(LangKeys.isRequired)}';
            }
            return null;
          },
          onChanged: onChanged,
          style: TextStyleApp.regular16().copyWith(
            color: context.onPrimaryColor,
          ),
          maxLength: maxLenght,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            isDense: true,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: context.primaryColor.withAlpha(90),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: context.primaryColor.withAlpha(90),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
