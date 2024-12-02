import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial(0)); // Start at index 0

  void nextPage() {
    final currentIndex = state.index;
    if (currentIndex < 2) {
      emit(OnboardingUpdated(currentIndex + 1));
    } else {
      emit(OnboardingFinished());
    }
  }

  void skip() {
    emit(OnboardingFinished());
  }
}
