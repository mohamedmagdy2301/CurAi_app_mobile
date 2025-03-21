// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({super.key});

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
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
        borderRadius: BorderRadius.circular(context.setR(10)),
        borderWidth: 0,
        fieldHeight: context.isLandscape ? context.setH(80) : context.setH(60),
        fieldWidth: context.isLandscape ? context.setW(20) : context.setW(60),
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
