import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
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
      validator: (value) {
        if (value == '') {
          return '${widget.labelText} ${context.translate(LangKeys.isRequired)}';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: isPasswordObscure,
      decoration: InputDecoration(
        border: customOutlineInputBorder(Colors.black),
        enabledBorder: customOutlineInputBorder(Colors.black),
        focusedBorder: customOutlineInputBorder(Colors.black),
        suffixIcon: changePasswordObscure(),
        labelText: widget.labelText,
        labelStyle: context.textTheme.bodyMedium!.copyWith(
            // color: context.colors.textColorLight,
            ),
      ),
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
              color: isPasswordObscure ? Colors.black : context.colors.primary,
              isPasswordObscure
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
            ),
          )
        : null;
  }

  OutlineInputBorder customOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
      borderSide: BorderSide(color: color),
    );
  }
}
