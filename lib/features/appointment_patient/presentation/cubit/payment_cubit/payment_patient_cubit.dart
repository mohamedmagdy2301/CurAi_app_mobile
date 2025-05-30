import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState {
  PaymentState({required this.status, this.errorMessage});

  factory PaymentState.initial() => PaymentState(status: PaymentStatus.initial);
  final PaymentStatus status;
  final String? errorMessage;

  PaymentState copyWith({PaymentStatus? status, String? errorMessage}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState.initial());

  void startLoading() => emit(state.copyWith(status: PaymentStatus.loading));

  void loadSuccess() => emit(state.copyWith(status: PaymentStatus.success));

  void loadFailure(String error) =>
      emit(state.copyWith(status: PaymentStatus.failure, errorMessage: error));
}
