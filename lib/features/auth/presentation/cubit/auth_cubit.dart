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
    final reslut = await _registerUsecase.call(registerRequest);
    reslut.fold((message) {
      emit(RegisterError(message: message));
    }, (message) {
      emit(RegisterSuccess(message: message));
    });
  }
}
