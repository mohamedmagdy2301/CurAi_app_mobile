import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as int_ex;
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/register/already_have_account.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/register/form_register_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: context.isLandscape
                ? context.padding(horizontal: 100, vertical: 35)
                : context.padding(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderAuthWidget(
                    title: LangKeys.createAccount,
                    descraption: LangKeys.descriptionRegister,
                  ),
                  15.hSpace,
                  const RegistrationFormWidget(),
                  20.hSpace,
                  const TermsOfServiceWidget(),
                  10.hSpace,
                  const AlreadyHaveAccountWidget(),
                  30.hSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
