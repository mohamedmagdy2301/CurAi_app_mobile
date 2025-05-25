import 'package:curai_app_mobile/features/onboarding/data/onboarding_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial(0));

  void nextPage() {
    final currentIndex = state.index;
    if (currentIndex < OnboardingInfo.onboardingInfo.length - 1) {
      if (isClosed) return;

      emit(OnboardingUpdated(currentIndex + 1));
    } else {
      if (isClosed) return;
      emit(OnboardingFinished());
    }
  }

  void skip() {
    if (isClosed) return;
    emit(OnboardingFinished());
  }
}
