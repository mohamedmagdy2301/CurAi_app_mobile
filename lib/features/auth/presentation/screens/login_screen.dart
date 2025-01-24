import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/form_login_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/not_have_account.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login_with_social.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.isLandscape
              ? padding(horizontal: 100, vertical: 35)
              : padding(horizontal: 20, vertical: 0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAuthWidger(
                  title: LangKeys.welcomeBack,
                  descraption: LangKeys.descriptionLogin,
                ),
                const FormLoginWidget(),
                spaceHeight(35),
                const LoginWithSocial(),
                spaceHeight(35),
                const TermsAndConditionsWidget(),
                spaceHeight(15),
                const NotHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
