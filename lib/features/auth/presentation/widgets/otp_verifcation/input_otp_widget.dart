// ignore: lines_longer_than_80_chars
// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously, document_ignores

import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toastification/toastification.dart';

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
      type: ToastificationType.success,
      message: 'PIN is correct, successfully',
    );
  }

  void _onPinIncorrect() {
    setState(() {
      activeFillColor = Colors.redAccent.shade400;
      textEditingController.clear();
    });
    hideKeyboard();
    if (context.mounted) {
      showMessage(
        context,
        type: ToastificationType.error,
        message: 'PIN is not correct, try again',
      );
    }
  }

  void _resetActiveFillColor() {
    setState(() {
      activeFillColor = context.backgroundColor;
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
      textStyle: TextStyleApp.light34().copyWith(
        color: context.onPrimaryColor,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0,
        fieldHeight: context.isLandscape ? 80 : 60,
        fieldWidth: context.isLandscape ? 20 : 40,
        activeColor: Colors.transparent,
        inactiveColor: Colors.transparent,
        selectedColor: Colors.transparent,
        activeFillColor: activeFillColor,
        inactiveFillColor: context.onSecondaryColor.withAlpha(70),
        selectedFillColor: context.onSecondaryColor.withAlpha(170),
      ),
      enableActiveFill: true,
      controller: textEditingController,
      onChanged: _handlePinChange,
      beforeTextPaste: (text) => true,
      appContext: context,
    );
  }
}
