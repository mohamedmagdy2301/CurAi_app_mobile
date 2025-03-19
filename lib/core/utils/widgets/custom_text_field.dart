import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramadan_app/core/constants/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.labelText,
    super.key,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.boarderColor,
    this.maxLines,
    this.isRequired,
    this.validatorPassword,
    this.validator,
  });
  final String labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged, validatorPassword;
  final Color? boarderColor;
  final int? maxLines;
  final String? Function(String?)? validator;

  final bool? isRequired;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "مطلوب ${widget.labelText}";
            }
            if (widget.validatorPassword != null) {
              return widget.validatorPassword!(value);
            }
            return null;
          },
      onChanged: widget.onChanged,
      maxLines: widget.maxLines ?? 1,
      obscureText: isPasswordObscure,
      style: StyleText.regular12(),
      decoration: InputDecoration(
        hintText: 'أدخل ${widget.labelText}',
        hintStyle: StyleText.regular12().copyWith(),
        border: customOutlineInputBorder(color: widget.boarderColor),
        enabledBorder: customOutlineInputBorder(color: widget.boarderColor),
        focusedBorder: customOutlineInputBorder(color: widget.boarderColor),
        focusedErrorBorder: customOutlineInputBorder(color: Colors.red),
        errorBorder: customOutlineInputBorder(color: Colors.red),
        suffixIcon: changePasswordObscure(),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      borderSide: BorderSide(color: color ?? Colors.grey),
    );
  }

  IconButton? changePasswordObscure() {
    return widget.obscureText != null
        ? IconButton(
          onPressed: () {
            setState(() {
              isPasswordObscure = !isPasswordObscure;
            });
          },
          icon: Icon(
            isPasswordObscure
                ? CupertinoIcons.eye_fill
                : CupertinoIcons.eye_slash_fill,
            color: isPasswordObscure ? Colors.grey : Colors.black,
            size: 20.sp,
          ),
        )
        : null;
  }
}
