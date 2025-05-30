import 'dart:io';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class BioFormWidget extends StatefulWidget {
  const BioFormWidget({
    required this.isEdit,
    this.specialization,
    super.key,
  });
  final String? specialization;
  final bool isEdit;

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
  final TextEditingController _certificationsController =
      TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final FocusNode _experienceFocus = FocusNode();
  final FocusNode _universityFocus = FocusNode();
  final FocusNode _hospitalFocus = FocusNode();
  final FocusNode _certificationsFocus = FocusNode();
  final FocusNode _skillsFocus = FocusNode();

  String? _selectedDegree;

  // Files and images
  final List<File> _selectedFiles = [];
  final List<File> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  String? _degreeErrorText;
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
    return DegreeConstants.getDegreesByLanguage(
      isArabic: context.isStateArabic,
    );
  }

  void updateBio() {
    final isValid = _formKey.currentState?.validate() ?? false;
    _degreeErrorText = _selectedDegree == null
        ? context.isStateArabic
            ? 'من فضلك اختر الدرجة العلمية'
            : 'Please select degree'
        : null;
    setState(() {});

    final newBio = DoctorBioParser.generateBio(
      experience: _experienceController.text,
      degree: _selectedDegree,
      university: _universityController.text,
      hospital: _hospitalController.text,
      specialization: widget.specialization,
      certifications: _certificationsController.text,
      skills: _skillsController.text,
      isArabic: context.isStateArabic,
    );

    _bioController.text = newBio;
    setState(() {});
    _isFormValidNotifier.value = isValid && _degreeErrorText == null;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImages
            ..clear()
            ..add(File(image.path));
        });
      }
    } on Exception catch (_) {
      if (!mounted) return;
      showMessage(
        context,
        type: ToastificationType.error,
        message: context.isStateArabic
            ? 'حدث خطأ أثناء اختيار الصورة'
            : 'An error occurred while selecting the image',
      );
    }
  }

  void showImagePickerOptions() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Wrap(
              children: <Widget>[
                // عنوان للقائمة
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  child: Text(
                    context.isStateArabic
                        ? 'اختر مصدر الصورة'
                        : 'Choose image source',
                    style: TextStyleApp.medium16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading:
                      Icon(Icons.photo_library, color: context.primaryColor),
                  title: Text(
                    context.isStateArabic ? 'معرض الصور' : 'Gallery',
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await pickImage(ImageSource.gallery);
                    } on Exception catch (_) {
                      await pickImage(ImageSource.gallery);
                    }
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.photo_camera, color: context.primaryColor),
                  title: Text(
                    context.isStateArabic ? 'الكاميرا' : 'Camera',
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await pickImage(ImageSource.camera);
                    } on Exception catch (_) {
                      await pickImage(ImageSource.camera);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onCompletePressed(BuildContext context) {
    hideKeyboard();
    updateBio();
    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();

      if (_selectedImages.isEmpty) {
        showMessage(
          context,
          type: ToastificationType.error,
          message: context.isStateArabic
              ? 'يرجى اختيار صورة'
              : 'Please select an image',
        );
        return;
      }

      final profileRequest = ProfileRequest(
        bio: _bioController.text.trim(),
        // Add any files or images to the request
        // This depends on how your ProfileRequest is structured
        profileCertificate: _selectedImages[0],
        // profileFiles: _selectedFiles,
      );
      context
          .read<AuthCubit>()
          .editProfile(context, profileRequest: profileRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: _isFormValidNotifier.value ? 0.h : 6.h,
        children: [
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          Row(
            children: [
              CustomTextFeild(
                labelText: context.isStateArabic
                    ? 'سنوات الخبرة'
                    : 'Years of Experience',
                keyboardType: TextInputType.number,
                controller: _experienceController,
                focusNode: _experienceFocus,
                textInputAction: TextInputAction.next,
                hint: context.isStateArabic ? 'مثال: 10' : 'e.g. 10',
                onChanged: (_) => updateBio(),
              ).expand(),
              10.wSpace,
              dropdownDergree(context).expand(),
            ],
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.isStateArabic ? 'الجامعة' : 'University',
            keyboardType: TextInputType.text,
            controller: _universityController,
            focusNode: _universityFocus,
            textInputAction: TextInputAction.next,
            nextFocusNode: _hospitalFocus,
            hint: context.isStateArabic
                ? 'الجامعة التي تم تخرج منها'
                : 'University you graduated from',
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.isStateArabic ? 'المستشفى' : 'Hospital',
            keyboardType: TextInputType.text,
            controller: _hospitalController,
            focusNode: _hospitalFocus,
            nextFocusNode: _skillsFocus,
            textInputAction: TextInputAction.next,
            hint: context.isStateArabic
                ? 'المستشفى التي تعمل فيه'
                : 'Hospital you work in',
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.isStateArabic ? 'المهارات' : 'Skills',
            keyboardType: TextInputType.text,
            controller: _skillsController,
            focusNode: _skillsFocus,
            nextFocusNode: _certificationsFocus,
            isValidator: false,
            textInputAction: TextInputAction.next,
            onChanged: (_) => updateBio(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          // CustomTextFeild(
          //   labelText: context.isStateArabic ? 'الشهادات' : 'Certifications',
          //   keyboardType: TextInputType.text,
          //   controller: _certificationsController,
          //   focusNode: _certificationsFocus,
          //   isValidator: false,
          //   textInputAction: TextInputAction.done,
          //   onChanged: (_) => updateBio(),
          // ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          buildUploadSection(),
          30.hSpace,
          buildCompleteButton(),
        ],
      ),
    );
  }

  Widget buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.isStateArabic ? 'رفع صور وملفات' : 'Upload Images and Files',
          style: TextStyleApp.medium16().copyWith(
            color: context.onPrimaryColor,
          ),
        ),
        12.hSpace,
        Row(
          children: [
            buildUploadButton(
              icon: Icons.image,
              label: context.isStateArabic ? 'إضافة صورة' : 'Add Image',
              onTap: showImagePickerOptions,
            ).expand(),
            16.wSpace,
            buildUploadButton(
              icon: Icons.upload_file,
              label: context.isStateArabic ? 'إضافة ملف' : 'Add File',
              onTap: () {
                showMessage(
                  context,
                  message: context.isStateArabic
                      ? 'قريبا\nهذه الميزة غير متوفرة حاليا'
                      : 'Soon!\nThis feature is not available right now',
                  type: ToastificationType.info,
                );
              },
            ).expand(),
          ],
        ),
        if (_selectedImages.isNotEmpty || _selectedFiles.isNotEmpty) ...[
          16.hSpace,
          buildSelectedFilesList(),
        ],
      ],
    );
  }

  Widget buildUploadButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: context.primaryColor.withAlpha(100)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: context.primaryColor,
              size: 28.sp,
            ),
            8.hSpace,
            Text(
              label,
              style: TextStyleApp.regular14().copyWith(
                color: context.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedFilesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Images section
        if (_selectedImages.isNotEmpty) ...[
          Text(
            context.isStateArabic ? 'الصور المختارة' : 'Selected Images',
            style: TextStyleApp.medium14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          8.hSpace,
          ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length,
            separatorBuilder: (_, __) => 8.wSpace,
            itemBuilder: (context, index) {
              return buildImageItem(_selectedImages[index], index);
            },
          ).withHeight(100),
        ],

        // Files section
        if (_selectedFiles.isNotEmpty) ...[
          16.hSpace,
          Text(
            context.isStateArabic ? 'الملفات المختارة' : 'Selected Files',
            style: TextStyleApp.medium14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          8.hSpace,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _selectedFiles.length,
            separatorBuilder: (_, __) => 8.hSpace,
            itemBuilder: (context, index) {
              return buildFileItem(_selectedFiles[index], index);
            },
          ),
        ],
      ],
    );
  }

  Widget buildImageItem(File image, int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: -8.h,
          right: -8.w,
          child: buildRemoveButton(() {
            setState(() {
              _selectedImages.removeAt(index);
            });
          }),
        ),
      ],
    ).paddingSymmetric(horizontal: 8, vertical: 8);
  }

  Widget buildFileItem(File file, int index) {
    final fileName = file.path.split('/').last;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.primaryColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            color: context.primaryColor,
            size: 24.sp,
          ),
          12.wSpace,
          Expanded(
            child: Text(
              fileName,
              style: TextStyleApp.regular14().copyWith(
                color: context.onPrimaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          10.wSpace,
          buildRemoveButton(() {
            setState(() {
              _selectedFiles.removeAt(index);
            });
          }),
        ],
      ),
    );
  }

  Widget buildRemoveButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 16.sp,
        ),
      ),
    );
  }

  Widget buildCompleteButton() {
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
          if (widget.isEdit) {
            context.pushReplacementNamed(Routes.mainScaffoldUser);
          } else {
            context
              ..pop()
              ..pushReplacementNamed(
                Routes.addAddreesClinicScreen,
                arguments: {'isEdit': false},
              );
          }
          context.read<AuthCubit>().clearState();
        }
        if (state is EditProfileError) {
          context.pop();
          showMessage(
            context,
            type: ToastificationType.error,
            message: state.message,
          );
          context.read<AuthCubit>().clearState();
        }
        if (state is EditProfileLoading) {
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

  Widget dropdownDergree(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: _degreeErrorText != null
                  ? Colors.redAccent.withAlpha(140)
                  : context.onPrimaryColor.withAlpha(60),
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
                size: 24.sp,
                color: context.onPrimaryColor.withAlpha(140),
              ),
              value: _selectedDegree,
              hint: Text(
                context.isStateArabic ? 'اختر الدرجة العلمية' : 'Select Degree',
                style: TextStyleApp.regular12().copyWith(
                  color: context.onPrimaryColor.withAlpha(140),
                ),
              ),
              items: getDegrees()
                  .map(
                    (degree) => DropdownMenuItem<String>(
                      value: degree,
                      child: Text(
                        degree,
                        style: TextStyleApp.regular14().copyWith(
                          color: context.onPrimaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDegree = newValue;
                  _degreeErrorText = null;

                  updateBio();
                });
              },
            ),
          ),
        ),
        if (_degreeErrorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 8.w),
            child: Text(
              _degreeErrorText!,
              style: TextStyleApp.regular12().copyWith(
                color: Colors.redAccent.withAlpha(200),
              ),
            ),
          ),
      ],
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
    _skillsController.dispose();
    _certificationsController.dispose();

    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
