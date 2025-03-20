import 'package:curai_app_mobile/core/di/dependency_injection.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/form_login_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login/not_have_account.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/login_with_social.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: context.isLandscape
                ? context.padding(horizontal: 100, vertical: 35)
                : context.padding(horizontal: 20, vertical: 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderAuthWidget(
                    title: LangKeys.welcomeBack,
                    descraption: LangKeys.descriptionLogin,
                  ),
                  const FormLoginWidget(),
                  context.spaceHeight(35),
                  const SocialAuthenticationWidget(),
                  context.spaceHeight(35),
                  const TermsOfServiceWidget(),
                  context.spaceHeight(15),
                  const NotHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
