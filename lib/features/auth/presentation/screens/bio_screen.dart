import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/complete_profile/form_bio_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({
    required this.isEdit,
    this.specialization,
    super.key,
  });
  final String? specialization;
  final bool isEdit;

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
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
                  20.hSpace,
                  HeaderAuthWidget(
                    title: LangKeys.bio,
                    descraption: LangKeys.completeProfileDescription,
                    isBack: widget.isEdit,
                  ),
                  20.hSpace,
                  BioFormWidget(
                    isEdit: widget.isEdit,
                    specialization: widget.specialization,
                  ),
                  35.hSpace,
                  const TermsOfServiceWidget(),
                  15.hSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
