import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/common/screens/portrait_screen.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:smartcare_app_mobile/features/auth/presentation/widgets/otp_verifcation/input_otp_widget.dart';

class OtpVerifcationScreen extends StatelessWidget {
  const OtpVerifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PortraitScreen(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: context.isLandscape
                  ? padding(horizontal: 120, vertical: 35)
                  : padding(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderAuthWidger(
                    title: LangKeys.otpVerification,
                    descraption: LangKeys.pinDescription,
                  ),
                  spaceHeight(30),
                  Expanded(
                    child: Column(
                      children: [
                        OtpInputWidget(),
                        spaceHeight(30),
                        Center(
                          child: Text(
                            'Code:  5555',
                            style: context.textTheme.displaySmall!.copyWith(
                              color: context.colors.textColorLight,
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
