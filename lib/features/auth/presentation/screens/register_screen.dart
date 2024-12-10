import 'package:flutter/material.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login_with_social.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/register/already_have_account.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/register/form_register_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.isLandscape
              ? padding(horizontal: 100, vertical: 35)
              : padding(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAuthWidger(
                  title: LangKeys.createAccount,
                  descraption: LangKeys.descriptionRegister,
                ),
                const FormRegisterWidget(),
                spaceHeight(30),
                const LoginWithSocial(),
                spaceHeight(25),
                const TermsAndConditionsWidget(),
                spaceHeight(10),
                const AleadyHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
