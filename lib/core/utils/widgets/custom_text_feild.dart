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
    this.isValidator,
    this.suffixIcon,
    this.maxLines,
    this.isLable,
    this.hint,
    this.maxLenght,
    this.prefixIcon,
    this.focusNode,
    this.textInputAction,
    this.nextFocusNode,
  });
  final String labelText;
  final String? hint;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? isLable;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final bool? isValidator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLenght;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final FocusNode? nextFocusNode;

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
      autofillHints: widget.autofillHints,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: context.primaryColor,
      style: TextStyleApp.regular16().copyWith(
        color: context.onPrimaryColor,
        decoration: TextDecoration.none,
      ),
      // autocorrect: false,
      // enableSuggestions: false,
      maxLength: widget.maxLenght,
      maxLines: widget.maxLines ?? 1,
      cursorHeight: 26.h,
      cursorWidth: 1.2.w,
      validator: widget.isValidator ?? true
          ? (value) {
              if (value == '') {
                return '${widget.labelText} '
                    '${context.translate(LangKeys.isRequired)}';
              }
              return null;
            }
          : (v) {
              return null;
            },
      onChanged: widget.onChanged,
      obscureText: isPasswordObscure,

      decoration: InputDecoration(
        filled: true,
        fillColor: context.backgroundColor,
        contentPadding: context.W > 400
            ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)
            : null,
        suffixIcon: widget.suffixIcon ?? changePasswordObscure(),
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        hintText: widget.hint ?? widget.labelText,
        alignLabelWithHint: true,
      ),

      onFieldSubmitted: (value) {
        if (widget.textInputAction == TextInputAction.next &&
            widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
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
                  ? context.onSecondaryColor.withAlpha(120)
                  : context.primaryColor,
              isPasswordObscure
                  ? CupertinoIcons.eye_slash
                  : CupertinoIcons.eye_fill,
            ),
          ).paddingSymmetric(horizontal: 5)
        : null;
  }
}
