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
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContCompleteProfileFormWidget extends StatefulWidget {
  const ContCompleteProfileFormWidget({required this.isUserDoctor, super.key});
  final bool isUserDoctor;
  @override
  State<ContCompleteProfileFormWidget> createState() =>
      _ContCompleteProfileFormWidgetState();
}

class _ContCompleteProfileFormWidgetState
    extends State<ContCompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _consultationPriceController =
      TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // A ValueNotifier to track the form validation status
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  int? selectedSpecialization;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _specializationErrorText = selectedSpecialization == null
        ? context.isStateArabic
            ? 'من فضلك اختر التخصص'
            : 'Please select specialization'
        : null;
    setState(() {});
    _isFormValidNotifier.value = isValid && _specializationErrorText == null;
  }

  void _onContCompletePressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    // if (_isFormValidNotifier.value) {
    //   _formKey.currentState?.save();

    context.pushReplacementNamed(Routes.loginScreen);
    // }
  }

  String? _specializationErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          if (!widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (!widget.isUserDoctor)
            CustomTextFeild(
              labelText: context.translate(LangKeys.address),
              keyboardType: TextInputType.streetAddress,
              controller: _addressController,
              maxLines: 2,
              onChanged: (_) => _validateForm(),
            ),
          if (widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (widget.isUserDoctor)
            CustomTextFeild(
              labelText: context.translate(LangKeys.consultationPrice),
              keyboardType: TextInputType.number,
              controller: _consultationPriceController,
              onChanged: (_) => _validateForm(),
            ),
          if (widget.isUserDoctor)
            HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          if (widget.isUserDoctor)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: _specializationErrorText != null
                          ? Colors.redAccent
                          : context.primaryColor.withAlpha(100),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(8.r),
                      elevation: 0,
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onPrimaryColor,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.sp,
                        color: context.primaryColor,
                      ),
                      value: selectedSpecialization,
                      hint: Text(
                        context.translate(LangKeys.medicalSpecialization),
                        style: TextStyleApp.regular16().copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            'Specialization 1',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Specialization 2',
                            style: TextStyleApp.regular16().copyWith(
                              color: context.onPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedSpecialization = newValue;
                          _specializationErrorText = null;
                        });
                      },
                    ),
                  ),
                ),
                if (_specializationErrorText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 8.w),
                    child: Text(
                      _specializationErrorText!,
                      style: TextStyleApp.regular12().copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
              ],
            ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.aboutMe),
            keyboardType: TextInputType.text,
            controller: _bioController,
            maxLines: 3,
            isLable: false,
            isValidator: false,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          10.hSpace,
          _buildContCompleteButton(),
        ],
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _buildContCompleteButton() {
    return BlocConsumer<AuthCubit, AuthState>(
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
            title: context.translate(LangKeys.completeProfileTitle),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.completeProfile,
          onPressed: () => _onContCompletePressed(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _specializationController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    _consultationPriceController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
