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
import 'package:curai_app_mobile/features/auth/data/models/profile/doctor_bio_parser.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class BioFormWidget extends StatefulWidget {
  const BioFormWidget({super.key});

  @override
  State<BioFormWidget> createState() => _BioFormWidgetState();
}

class _BioFormWidgetState extends State<BioFormWidget> {
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final FocusNode _experienceFocus = FocusNode();
  final FocusNode _universityFocus = FocusNode();
  final FocusNode _hospitalFocus = FocusNode();

  String? _selectedDegree;

  @override
  void initState() {
    super.initState();
    // Try to parse existing bio if available
    _parseExistingBio();
  }

  void _parseExistingBio() {
    if (_bioController.text.isNotEmpty) {
      final bioText = _bioController.text;

      // Try to detect degree in existing bio
      for (final degree in getDegrees()) {
        if (bioText.contains(degree)) {
          setState(() {
            _selectedDegree = degree;
          });
          break;
        }
      }

      // Try to extract experience years
      final experienceRegex = RegExp(
        r'(\d+)(?:\+)?\s+(?:years|سنوات|عام|سنة)\s+(?:of\s+)?(?:experience|خبرة)',
      );
      final experienceMatch = experienceRegex.firstMatch(bioText);
      if (experienceMatch != null) {
        _experienceController.text = experienceMatch.group(1) ?? '';
      }

      // Try to extract university
      final universityRegex = RegExp(
        r'(?:from|graduated from|متخرج من|من جامعة)\s+([A-Za-zأ-ي\s]+)(?:University|جامعة)?',
        caseSensitive: false,
      );
      final universityMatch = universityRegex.firstMatch(bioText);
      if (universityMatch != null) {
        _universityController.text = universityMatch.group(1)?.trim() ?? '';
      }

      // Try to extract hospital
      final hospitalRegex = RegExp(
        r'(?:at|in|في)\s+([A-Za-zأ-ي\s]+)(?:Hospital|مستشفى|مركز|Center)',
        caseSensitive: false,
      );
      final hospitalMatch = hospitalRegex.firstMatch(bioText);
      if (hospitalMatch != null) {
        _hospitalController.text = hospitalMatch.group(1)?.trim() ?? '';
      }
    }
  }

  // Get degrees list based on language
  List<String> getDegrees() {
    return DegreeConstants.getDegreesByLanguage(context.isStateArabic);
  }

  void updateBio() {
    final isValid = _formKey.currentState?.validate() ?? false;

    final bioComponents = <String>[];

    // Add degree if available
    if (_selectedDegree != null && _selectedDegree!.isNotEmpty) {
      bioComponents.add(_selectedDegree!);
    }

    // Add experience if available
    if (_experienceController.text.isNotEmpty) {
      if (context.isStateArabic) {
        bioComponents.add('مع ${_experienceController.text} سنوات من الخبرة');
      } else {
        bioComponents
            .add('with ${_experienceController.text}+ years of experience');
      }
    }

    // Add hospital if available
    if (_hospitalController.text.isNotEmpty) {
      if (context.isStateArabic) {
        bioComponents.add('في مستشفى ${_hospitalController.text}');
      } else {
        bioComponents.add('at ${_hospitalController.text} Hospital');
      }
    }

    // Add university if available
    if (_universityController.text.isNotEmpty) {
      if (context.isStateArabic) {
        bioComponents.add('متخرج من جامعة ${_universityController.text}');
      } else {
        bioComponents
            .add('graduated from ${_universityController.text} University');
      }
    }

    // Join components and update main bio
    final separator = context.isStateArabic ? '، ' : ', ';
    final newBio = bioComponents.join(separator);

    _bioController.text = newBio;
    _isFormValidNotifier.value = isValid;
  }

  void onCompletePressed(BuildContext context) {
    hideKeyboard();
    updateBio();

    final profileRequest = ProfileRequest(
      bio: _bioController.text.trim(),
    );
    context
        .read<AuthCubit>()
        .editProfile(context, profileRequest: profileRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: _isFormValidNotifier.value ? 0.h : 6.h,
        children: [
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText:
                context.isStateArabic ? 'سنوات الخبرة' : 'Years of Experience',
            keyboardType: TextInputType.number,
            controller: _experienceController,
            focusNode: _experienceFocus,
            textInputAction: TextInputAction.next,
            hint: context.isStateArabic ? 'مثال: 10' : 'e.g. 10',
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          _dropdownDergree(context),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),

          CustomTextFeild(
            labelText: context.isStateArabic ? 'الجامعة' : 'University',
            keyboardType: TextInputType.text,
            controller: _universityController,
            focusNode: _universityFocus,
            textInputAction: TextInputAction.next,
            nextFocusNode: _hospitalFocus,
            hint: context.isStateArabic ? 'مثال: القاهرة' : 'e.g. Cairo',
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),

          // Hospital input
          CustomTextFeild(
            labelText: context.isStateArabic ? 'المستشفى' : 'Hospital',
            keyboardType: TextInputType.text,
            controller: _hospitalController,
            focusNode: _hospitalFocus,
            textInputAction: TextInputAction.done,
            hint: context.isStateArabic ? 'مثال: السلام' : 'e.g. Al Salam',
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          20.hSpace,
          _buildCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is EditProfileSuccess ||
          current is EditProfileError ||
          current is EditProfileLoading,
      buildWhen: (previous, current) =>
          current is EditProfileSuccess ||
          current is EditProfileError ||
          current is EditProfileLoading,
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          context
            ..pop()
            ..pushReplacementNamed(
              Routes.addAddreesClinicScreen,
              arguments: {'isEdit': false},
            );
        } else if (state is EditProfileError) {
          context.pop();
          showMessage(
            context,
            type: ToastificationType.error,
            message: state.message,
          );
        } else if (state is EditProfileLoading) {
          AdaptiveDialogs.showLoadingAlertDialog(
            context: context,
            title: context.translate(LangKeys.completeProfileTitle),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.complete,
          isLoading: state is EditProfileLoading,
          onPressed: () => onCompletePressed(context),
        );
      },
    );
  }

  Container _dropdownDergree(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.primaryColor.withAlpha(100),
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
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 30.sp,
            color: context.primaryColor,
          ),
          value: _selectedDegree,
          hint: Text(
            context.isStateArabic ? 'اختر الدرجة العلمية' : 'Select Degree',
            style: TextStyleApp.regular16().copyWith(
              color: context.primaryColor,
            ),
          ),
          items: getDegrees()
              .map(
                (degree) => DropdownMenuItem<String>(
                  value: degree,
                  child: Text(
                    degree,
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedDegree = newValue;
              updateBio();
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _experienceController.dispose();
    _universityController.dispose();
    _hospitalController.dispose();
    _bioController.dispose();
    _experienceFocus.dispose();
    _universityFocus.dispose();
    _hospitalFocus.dispose();

    super.dispose();
  }
}
