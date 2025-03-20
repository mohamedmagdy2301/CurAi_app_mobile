import 'package:bloc/bloc.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._registerUsecase) : super(AuthInitial());

  final RegisterUsecase _registerUsecase;

  Future<void> register(RegisterRequest registerRequest) async {
    emit(RegisterLoading());

    final result = await _registerUsecase(registerRequest);

    result.fold(
      (errorMessage) => emit(RegisterError(message: errorMessage)),
      (successMessage) => emit(RegisterSuccess(message: successMessage)),
    );
  }
}
