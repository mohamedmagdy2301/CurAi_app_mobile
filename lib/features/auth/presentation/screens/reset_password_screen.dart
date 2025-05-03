import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/forget_password/form_forget_password_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.padding(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderAuthWidget(
                title: LangKeys.forgotPassTitle,
                descraption: LangKeys.descriptionForgotPassword,
              ),
              45.hSpace,
              const Expanded(child: ResetPasswordFormWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
