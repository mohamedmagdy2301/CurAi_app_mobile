import 'package:flutter/material.dart';
import 'package:curai_app_mobile/core/common/screens/portrait_screen.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/forget_password/form_forget_password_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PortraitScreen(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: context.isLandscape
                ? padding(horizontal: 100, vertical: 35)
                : padding(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAuthWidger(
                  title: LangKeys.forgotPassTitle,
                  descraption: LangKeys.descriptionForgotPassword,
                ),
                spaceHeight(45),
                const Expanded(child: FormForgetPasswordWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
