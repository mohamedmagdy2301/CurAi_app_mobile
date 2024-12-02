import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/onboarding/data/onboarding_info.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial(0));

  void nextPage() {
    final currentIndex = state.index;
    if (currentIndex < OnboardingInfo.onboardingInfo.length - 1) {
      emit(OnboardingUpdated(currentIndex + 1));
    } else {
      emit(OnboardingFinished());
    }
  }

  void skip() {
    emit(OnboardingFinished());
  }
}
