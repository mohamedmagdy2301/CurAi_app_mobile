import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/change_password/form_change_password_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
            child: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderAuthWidget(
                    isBack: true,
                    title: LangKeys.changePassword,
                    descraption: LangKeys.descriptionChangePassword,
                  ),
                  FormChangePasswordWidget(),
                  // 60.hSpace,
                  // const TermsOfServiceWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
