// ignore_for_file: inference_failure_on_instance_creation, document_ignores

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

  Future<void> register(RegisterRequest registerRequest) async {
    emit(RegisterLoading());

    final result = await _registerUsecase.call(registerRequest);
    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(RegisterError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(RegisterSuccess(message: successMessage));
      },
    );
  }

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _loginUsecase.call(loginRequest);
    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(LoginError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(
          LoginSuccess(
            message: 'Welcome ${successMessage.username} in CurAi ☺️',
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await _logoutUsecase.call('');

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(LogoutError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(LogoutSuccess(message: successMessage));
      },
    );
  }

  Future<void> changePassword(
    ChangePasswordRequest changePasswordRequest,
  ) async {
    emit(ChangePasswordLoading());

    final result = await _changePasswordUsecase.call(changePasswordRequest);

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(ChangePasswordError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(ChangePasswordSuccess(message: successMessage));
      },
    );
  }

  Future<void> getProfile() async {
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

  Future<void> editProfile({
    required ProfileRequest profileRequest,
  }) async {
    emit(EditProfileLoading());

    final result = await _editProfileUsecase.call(profileRequest);
    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(EditProfileError(message: errorMessage));
      },
      (profileModel) {
        if (isClosed) return;
        emit(EditProfileSuccess(profileModel: profileModel));
      },
    );
  }

  Future<void> contactUs(ContactUsRequest contactUsRequest) async {
    emit(ContactUsLoading());

    final result = await _contactUsUsecase.call(contactUsRequest);
    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(ContactUsError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(ContactUsSuccess(message: successMessage));
      },
    );
  }
}
