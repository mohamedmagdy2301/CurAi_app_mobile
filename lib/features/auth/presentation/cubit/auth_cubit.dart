import 'package:bloc/bloc.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._registerUsecase, this._loginUsecase) : super(AuthInitial());

  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;

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
}
