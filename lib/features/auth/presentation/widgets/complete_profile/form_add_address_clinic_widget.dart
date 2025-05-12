import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/get_location/get_location_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/complete_profile/maps_card_add_new_address.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/height_valid_notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AddAddressClinicFormWidget extends StatefulWidget {
  const AddAddressClinicFormWidget({super.key, this.isEdit});
  final bool? isEdit;

  @override
  State<AddAddressClinicFormWidget> createState() =>
      _AddAddressClinicFormWidgetState();
}

class _AddAddressClinicFormWidgetState
    extends State<AddAddressClinicFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFormValidNotifier = ValueNotifier<bool>(true);

  final TextEditingController _specialMarkController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final FocusNode _specialMarkFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _areaFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _governorateFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  double? latitude;
  double? longitude;

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    _isFormValidNotifier.value = isValid;
  }

  void _onContCompletePressed(BuildContext context) {
    hideKeyboard();
    _validateForm();
    final cubitLocation = context.read<GetLocationCubit>().selectedLocation;

    if (_isFormValidNotifier.value) {
      _formKey.currentState?.save();
      if (cubitLocation.latitude == 0 || cubitLocation.longitude == 0) {
        showMessage(
          context,
          message: context.isStateArabic
              ? 'من فضلك اختر الموقع'
              : 'Please select location',
          type: ToastificationType.error,
        );
        return;
      }

      final profileRequest = ProfileRequest(
        location: '${_countryController.text} ${_governorateController.text} '
            '${_cityController.text} ${_areaController.text} '
            '${_streetController.text} ${_specialMarkController.text}',
        latitude: cubitLocation.latitude,
        longitude: cubitLocation.longitude,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const MapsCardAddNewAddress(),
          20.hSpace,
          Row(
            spacing: 10.w,
            children: [
              CustomTextFeild(
                labelText: context.translate(LangKeys.country),
                keyboardType: TextInputType.streetAddress,
                controller: _countryController,
                focusNode: _countryFocusNode,
                textInputAction: TextInputAction.next,
                nextFocusNode: _governorateFocusNode,
                onChanged: (_) => _validateForm(),
              ).expand(),
              CustomTextFeild(
                labelText: context.translate(LangKeys.governorate),
                keyboardType: TextInputType.streetAddress,
                controller: _governorateController,
                focusNode: _governorateFocusNode,
                textInputAction: TextInputAction.next,
                nextFocusNode: _cityFocusNode,
                onChanged: (_) => _validateForm(),
              ).expand(),
            ],
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.city),
            keyboardType: TextInputType.streetAddress,
            controller: _cityController,
            focusNode: _cityFocusNode,
            textInputAction: TextInputAction.next,
            nextFocusNode: _areaFocusNode,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.area),
            keyboardType: TextInputType.streetAddress,
            controller: _areaController,
            focusNode: _areaFocusNode,
            textInputAction: TextInputAction.next,
            nextFocusNode: _streetFocusNode,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.street),
            keyboardType: TextInputType.streetAddress,
            controller: _streetController,
            focusNode: _streetFocusNode,
            textInputAction: TextInputAction.next,
            nextFocusNode: _specialMarkFocusNode,
            onChanged: (_) => _validateForm(),
          ),
          HeightValidNotifier(isFormValidNotifier: _isFormValidNotifier),
          CustomTextFeild(
            labelText: context.translate(LangKeys.specialMark),
            keyboardType: TextInputType.streetAddress,
            controller: _specialMarkController,
            focusNode: _specialMarkFocusNode,
            maxLines: 2,
            textInputAction: TextInputAction.done,
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
          current is EditProfileSuccess ||
          current is EditProfileError ||
          current is EditProfileLoading,
      buildWhen: (previous, current) =>
          current is EditProfileSuccess ||
          current is EditProfileError ||
          current is EditProfileLoading,
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          if (widget.isEdit ?? false) {
            context.pushReplacementNamed(Routes.mainScaffoldUser);
          } else {
            context
              ..pop()
              ..pushReplacementNamed(Routes.loginScreen);
          }
          context.read<AuthCubit>().clearState();
        }
        if (state is EditProfileError) {
          showMessage(
            context,
            type: ToastificationType.error,
            message: state.message,
          );
        }
        context.read<AuthCubit>().clearState();
      },
      builder: (context, state) {
        return CustomButton(
          title: LangKeys.finish,
          isLoading: state is EditProfileLoading,
          onPressed: () => _onContCompletePressed(context),
        );
      },
    );
  }

  @override
  void dispose() {
    _areaController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _isFormValidNotifier.dispose();
    super.dispose();
  }
}
