// ignore_for_file: inference_failure_on_instance_creation, document_ignores

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/contact_us/contact_us_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/contact_us_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._registerUsecase,
    this._loginUsecase,
    this._logoutUsecase,
    this._changePasswordUsecase,
    this._getProfileUsecase,
    this._editProfileUsecase,
    this._contactUsUsecase,
  ) : super(AuthInitial());

  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;
  final GetProfileUsecase _getProfileUsecase;
  final EditProfileUsecase _editProfileUsecase;
  final ContactUsUsecase _contactUsUsecase;

  void clearState() {
    if (isClosed) return;
    emit(AuthInitial());
  }

  Future<void> register(
    BuildContext context,
    RegisterRequest registerRequest,
  ) async {
    if (isClosed) return;

    emit(RegisterLoading());

    final result = await _registerUsecase.call(registerRequest);
    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;

    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(RegisterError(message: errorMessage));
      },
      (successMessage) {
        final role = registerRequest.role;

        if (role == 'doctor') {
          displayedMessage = isArabic
              ? 'تم التسجيل بنجاح!\n'
                  'يرجى إكمال بياناتك لتفعيل حسابك.'
              : 'Registration successful!\n'
                  'Please complete your profile to activate your account.';
        } else {
          displayedMessage = isArabic
              ? 'تم التسجيل بنجاح!\nيرجى تسجيل الدخول للمتابعة.'
              : 'Registration successful!\nPlease log in to continue.';
        }

        if (isClosed) return;

        emit(RegisterSuccess(message: displayedMessage));
      },
    );
  }

  Future<void> login(
    BuildContext context,
    LoginRequest loginRequest,
  ) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _loginUsecase.call(loginRequest);
    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;

    result.fold(
      (errorMessage) {
        if (errorMessage
            .contains('No active account found with the given credentials')) {
          displayedMessage = isArabic
              ? 'البريد الالكتروني او اسم المستخدم او كلمة المرور غير صحيحة '
              : 'Invalid email or username or password';
        } else if (errorMessage.contains('account under review')) {
          displayedMessage = isArabic
              ? 'حسابك تحت المراجعة من قبل الإدارة.'
              : 'Your account is under review by the admin.';
        } else {
          displayedMessage = errorMessage;
        }

        if (isClosed) return;

        emit(LoginError(message: displayedMessage));
      },
      (successMessage) {
        final username =
            '${successMessage.firstName} ${successMessage.lastName}';
        final role = successMessage.role;

        displayedMessage = isArabic
            ? (role == 'doctor'
                ? 'مرحبًا دكتور $username، سعداء بعودتك في CurAi ☺️'
                : 'مرحبًا $username، نتمنى لك دوام الصحة في CurAi ☺️')
            : (role == 'doctor'
                ? 'Welcome Dr. $username, glad to have you back on CurAi ☺️'
                : 'Welcome $username, wishing you good health on CurAi ☺️');

        if (isClosed) return;

        emit(LoginSuccess(message: displayedMessage));
      },
    );
  }

  Future<void> logout(
    BuildContext context,
  ) async {
    emit(LogoutLoading());

    final result = await _logoutUsecase.call('');
    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;
    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(LogoutError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;

        displayedMessage = isArabic
            ? 'تم تسجيل الخروج بنجاح.\n'
                'نأمل أن نراك قريبًا في CurAi!'
            : 'You have logged out successfully.\n'
                'We hope to see you again soon on CurAi!';

        if (isClosed) return;

        emit(LogoutSuccess(message: displayedMessage));
      },
    );
  }

  Future<void> changePassword(
    BuildContext context,
    ChangePasswordRequest changePasswordRequest,
  ) async {
    emit(ChangePasswordLoading());

    final result = await _changePasswordUsecase.call(changePasswordRequest);
    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;

    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(ChangePasswordError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;

        displayedMessage = isArabic
            ? 'تم تغيير كلمة المرور بنجاح.\n'
                'يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.'
            : 'Password changed successfully.\n'
                'You can now log in with your new password.';

        if (isClosed) return;

        emit(ChangePasswordSuccess(message: displayedMessage));
      },
    );
  }

  Future<void> getProfile(
    BuildContext context,
  ) async {
    emit(GetProfileLoading());

    final result = await _getProfileUsecase.call('');

    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(GetProfileError(message: errorMessage));
      },
      (profileModel) {
        if (isClosed) return;

        emit(GetProfileSuccess(profileModel: profileModel));
      },
    );
  }

  Future<void> editProfile(
    BuildContext context, {
    required ProfileRequest profileRequest,
  }) async {
    emit(EditProfileLoading());

    final result = await _editProfileUsecase.call(profileRequest);
    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;
    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(EditProfileError(message: errorMessage));
      },
      (profileModel) {
        if (isClosed) return;

        displayedMessage = isArabic
            ? 'تم تعديل ملفك الشخصي بنجاح.\n'
                'البيانات الخاصة بك محدثة الآن!'
            : 'Your profile has been updated successfully.\n'
                'Your data is now up to date!';

        if (isClosed) return;

        emit(
          EditProfileSuccess(
            profileModel: profileModel,
            message: displayedMessage,
          ),
        );
      },
    );
  }

  Future<void> contactUs(
    BuildContext context,
    ContactUsRequest contactUsRequest,
  ) async {
    emit(ContactUsLoading());

    final result = await _contactUsUsecase.call(contactUsRequest);

    final isArabic = context.mounted && context.isStateArabic;
    String displayedMessage;
    result.fold(
      (errorMessage) {
        if (isClosed) return;

        emit(ContactUsError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;

        displayedMessage = isArabic
            ? 'شكرًا لتواصلك معنا.\n'
                'سيتم الرد على استفسارك قريبًا.'
            : 'Thank you for contacting us.\n'
                'Your inquiry will be answered soon.';

        if (isClosed) return;

        emit(ContactUsSuccess(message: displayedMessage));
      },
    );
  }
}
