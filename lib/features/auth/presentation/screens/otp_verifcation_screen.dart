import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/otp_verifcation/input_otp_widget.dart';
import 'package:flutter/material.dart';

class OtpVerifcationScreen extends StatelessWidget {
  const OtpVerifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: context.padding(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAuthWidget(
                  title: LangKeys.otpVerification,
                  descraption: LangKeys.pinDescription,
                ),
                30.hSpace,
                Expanded(
                  child: Column(
                    children: [
                      const OtpCodeInput(),
                      30.hSpace,
                      Center(
                        child: Text(
                          'Code:  5555',
                          style: TextStyleApp.extraBold22().copyWith(
                            color: context.onPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
