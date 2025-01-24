import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/otp_verifcation/input_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class OtpVerifcationScreen extends StatelessWidget {
  const OtpVerifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: context.isLandscape
                  ? context.padding(horizontal: 120, vertical: 35)
                  : context.padding(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderAuthWidger(
                    title: LangKeys.otpVerification,
                    descraption: LangKeys.pinDescription,
                  ),
                  context.spaceHeight(30),
                  Expanded(
                    child: Column(
                      children: [
                        const OtpInputWidget(),
                        context.spaceHeight(30),
                        Center(
                          child: Text(
                            'Code:  5555',
                            style: context.textTheme.displaySmall!.copyWith(
                                // color: context.colors.textColorLight,
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
      ),
    );
  }
}
