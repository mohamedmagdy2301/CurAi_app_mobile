import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/complete_profile/form_cont_complete_profile_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContCompleteProfileScreen extends StatefulWidget {
  const ContCompleteProfileScreen({super.key});

  @override
  State<ContCompleteProfileScreen> createState() =>
      _ContCompleteProfileScreenState();
}

class _ContCompleteProfileScreenState extends State<ContCompleteProfileScreen> {
  String userType = 'patient';

  Widget chooseUserType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['patient', 'doctor'].map((String type) {
        final isSelected = userType == type;
        return ChoiceChip(
          checkmarkColor: Colors.white,
          label: Row(
            children: [
              if (isSelected) 0.wSpace else 10.wSpace,
              Icon(
                isSelected ? Icons.person_2_outlined : Icons.person,
                color: isSelected ? Colors.white : context.primaryColor,
              ),
              if (isSelected) 10.wSpace else 15.wSpace,
              Text(
                type == 'patient' ? 'Patient' : 'Doctor',
              ),
              if (isSelected) 0.wSpace else 5.wSpace,
            ],
          ),
          selected: isSelected,
          selectedColor: context.primaryColor,
          backgroundColor: context.backgroundColor,
          elevation: 6,
          padding:
              EdgeInsets.symmetric(horizontal: context.W * 0.035, vertical: 15),
          labelStyle: TextStyleApp.medium20().copyWith(
            color: isSelected ? Colors.white : context.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: context.primaryColor),
          ),
          onSelected: (bool selected) {
            setState(() {
              userType = (selected ? type : userType);
            });
          },
        );
      }).toList(),
    );
  }

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
                    title: LangKeys.completeProfileTitle,
                    descraption: LangKeys.completeProfileDescription,
                  ),
                  30.hSpace,
                  chooseUserType(context),
                  if (userType == 'doctor') 10.hSpace else 20.hSpace,
                  ContCompleteProfileFormWidget(
                    isUserDoctor: userType == 'doctor',
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
