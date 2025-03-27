// ignore_for_file: inference_failure_on_instance_creation

import 'package:bloc/bloc.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._registerUsecase,
    this._loginUsecase,
    this._logoutUsecase,
    this._changePasswordUsecase,
    this._profileUsecase,
  ) : super(AuthInitial());

  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;
  final ProfileUsecase _profileUsecase;

  Future<void> register(RegisterRequest registerRequest) async {
    emit(RegisterLoading());

    final result = await _registerUsecase.call(registerRequest);

    result.fold(
      (errorMessage) => emit(RegisterError(message: errorMessage)),
      (successMessage) => emit(RegisterSuccess(message: successMessage)),
    );
  }

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _loginUsecase.call(loginRequest);

    result.fold(
      (errorMessage) => emit(LoginError(message: errorMessage)),
      (successMessage) => emit(
        LoginSuccess(
          message: 'Welcome ${successMessage.username} in CurAi ☺️',
        ),
      ),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await _logoutUsecase.call('');

    result.fold(
      (errorMessage) => emit(LogoutError(message: errorMessage)),
      (successMessage) => emit(LogoutSuccess(message: successMessage)),
    );
  }

  Future<void> changePassword(
    ChangePasswordRequest changePasswordRequest,
  ) async {
    emit(ChangePasswordLoading());

    final result = await _changePasswordUsecase.call(changePasswordRequest);

    result.fold(
      (errorMessage) => emit(ChangePasswordError(message: errorMessage)),
      (successMessage) => emit(ChangePasswordSuccess(message: successMessage)),
    );
  }

  Future<void> getProfile() async {
    emit(GetProfileLoading());

    final result = await _profileUsecase.call('');

    result.fold(
      (errorMessage) => emit(GetProfileError(message: errorMessage)),
      (profileModel) => emit(GetProfileSuccess(profileModel: profileModel)),
    );
  }
}
