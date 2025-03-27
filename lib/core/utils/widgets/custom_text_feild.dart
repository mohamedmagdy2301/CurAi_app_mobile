import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFeild extends StatefulWidget {
  const CustomTextFeild({
    required this.labelText,
    super.key,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.autofillHints,
    this.onChanged,
  });
  final String labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  late bool isPasswordObscure;

  @override
  void initState() {
    super.initState();
    isPasswordObscure = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      controller: widget.controller,
      autofillHints: widget.autofillHints ?? const [],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: context.primaryColor,
      style: TextStyleApp.regular16().copyWith(
        color: context.onPrimaryColor,
        decoration: TextDecoration.none,
      ),
      // autocorrect: false,
      // enableSuggestions: false,
      cursorHeight: 26.h,
      cursorWidth: 1.2.w,
      validator: (value) {
        if (value == '') {
          return '${widget.labelText} ${context.translate(LangKeys.isRequired)}';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: isPasswordObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.backgroundColor,
        contentPadding: context.W > 400
            ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h)
            : null,
        errorStyle: TextStyleApp.regular14().copyWith(
          color: Colors.redAccent,
        ),
        suffixIcon: changePasswordObscure(),
        labelText: widget.labelText,
      ),
    );
  }

  Widget? changePasswordObscure() {
    return widget.obscureText != null
        ? IconButton(
            onPressed: () {
              setState(() {
                isPasswordObscure = !isPasswordObscure;
              });
            },
            icon: Icon(
              size: 26.sp,
              color: isPasswordObscure
                  ? context.onSecondaryColor
                  : context.primaryColor,
              isPasswordObscure
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
            ),
          ).paddingSymmetric(horizontal: 5)
        : null;
  }
}
