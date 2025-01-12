// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputWidget extends StatefulWidget {
  const OtpInputWidget({super.key});

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  final TextEditingController textEditingController = TextEditingController();
  final String correctPin = '5555';
  Color activeFillColor = Colors.greenAccent.shade400;

  Future<void> _handlePinChange(String value) async {
    if (value.length == correctPin.length) {
      if (value == correctPin) {
        await _onPinCorrect();
      } else {
        _onPinIncorrect();
      }
    } else {
      _resetActiveFillColor();
    }
  }

  Future<void> _onPinCorrect() async {
    hideKeyboard();
    await Future.delayed(const Duration(milliseconds: 100)).then((c) {
      context.pushReplacementNamed(Routes.mainScaffoldUser);
    });
    showMessage(
      context,
      type: SnackBarType.success,
      message: 'PIN is correct, successfully',
    );
  }

  void _onPinIncorrect() {
    setState(() {
      activeFillColor = context.color.error;
      textEditingController.clear();
    });
    hideKeyboard();
    if (context.mounted) {
      showMessage(
        context,
        type: SnackBarType.error,
        message: 'PIN is not correct, try again',
      );
    }
  }

  void _resetActiveFillColor() {
    setState(() {
      activeFillColor = context.color.primary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 4,
      keyboardType: TextInputType.number,
      cursorHeight: 25,
      autoFocus: true,
      animationType: AnimationType.fade,
      cursorWidth: 1,
      textStyle: context.styleBlack34.copyWith(
        color: context.color.surface,
        fontWeight: FontWeightHelper.light,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0,
        fieldHeight: context.isLandscape ? 80.h : 60.h,
        fieldWidth: context.isLandscape ? 20.w : 60.w,
        activeColor: Colors.transparent,
        inactiveColor: Colors.transparent,
        selectedColor: Colors.transparent,
        activeFillColor: activeFillColor,
        inactiveFillColor: context.color.onSecondary.withAlpha(70),
        selectedFillColor: context.color.onSecondary.withAlpha(170),
      ),
      enableActiveFill: true,
      controller: textEditingController,
      onChanged: _handlePinChange,
      beforeTextPaste: (text) => true,
      appContext: context,
    );
  }
}
