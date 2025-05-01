import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/register/already_have_account.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
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
              EdgeInsets.symmetric(horizontal: context.W * 0.035, vertical: 5),
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
                    title: LangKeys.createAccount,
                    descraption: LangKeys.descriptionRegister,
                  ),
                  10.hSpace,
                  chooseUserType(context),
                  const CompleteProfileFormWidget(),
                  35.hSpace,
                  const TermsOfServiceWidget(),
                  15.hSpace,
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

class CompleteProfileFormWidget extends StatefulWidget {
  const CompleteProfileFormWidget({super.key});

  @override
  State<CompleteProfileFormWidget> createState() =>
      _CompleteProfileFormWidgetState();
}

class _CompleteProfileFormWidgetState extends State<CompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _yourAgeController = TextEditingController();
  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  String? selectedGender;

  final bool _isPasswordObscure = true;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _isFormValidNotifier.value = isValid;
  }

  void _onRegisterPressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();

      // context.read<AuthCubit>().register(
      //       RegisterRequest(
      //         email: _emailController.text.trim(),
      //         password: _passwordController.text.trim(),
      //         username: _userNameController.text.trim(),
      //         confirmPassword: _confirmPasswordController.text.trim(),
      //         // firstName: _fullNameController.text,
      //         // phoneNumber: _phoneController.text,
      //         // location: _addressController.text,
      //         // age: int.parse(_yourAgeController.text),
      //         // gender: selectedGender ?? 'male',
      //         // specialization: '1',
      //         // consultationPrice: '100',
      //       ),
      //     );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.userName),
            keyboardType: TextInputType.name,
            controller: _userNameController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.fullName),
            keyboardType: TextInputType.name,
            controller: _fullNameController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.email),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.phone),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.address),
            keyboardType: TextInputType.streetAddress,
            controller: _addressController,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.W * .3,
                  child: CustomTextFeild(
                    labelText: context.translate(LangKeys.yourAge),
                    keyboardType: TextInputType.number,
                    controller: _yourAgeController,
                    onChanged: (_) => _validateForm(),
                  ),
                ),
                Container(
                  width: context.W * .55,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: context.primaryColor.withAlpha(90),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(8.r),
                      elevation: 0,
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onPrimaryColor,
                      ),
                      isDense: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedGender,
                      hint: Text(
                        context.translate(LangKeys.gender),
                        style: TextStyleApp.regular16().copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'male',
                          child: Text(context.translate(LangKeys.male)),
                        ),
                        DropdownMenuItem(
                          value: 'female',
                          child: Text(context.translate(LangKeys.female)),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.password),
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: _isPasswordObscure,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.confirmPassword),
            keyboardType: TextInputType.visiblePassword,
            controller: _confirmPasswordController,
            obscureText: _isPasswordObscure,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          5.hSpace,
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current is RegisterLoading ||
                current is RegisterSuccess ||
                current is RegisterError,
            listener: (context, state) {
              if (state is RegisterError) {
                Navigator.pop(context);
                showMessage(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is RegisterSuccess) {
                Navigator.pop(context);
                showMessage(
                  context,
                  message: state.message,
                  type: SnackBarType.success,
                );
                context.pushNamed(Routes.loginScreen);
              } else if (state is RegisterLoading) {
                AdaptiveDialogs.showLoadingAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.register),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                title: LangKeys.completeProfile,
                onPressed: () => _onRegisterPressed(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
