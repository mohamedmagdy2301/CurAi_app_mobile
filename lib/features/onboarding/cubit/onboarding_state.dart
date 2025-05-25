part of 'onboarding_cubit.dart';

abstract class OnboardingState {
  const OnboardingState(this.index);
  final int index;
}

class OnboardingInitial extends OnboardingState {
  OnboardingInitial(super.index);
}

class OnboardingUpdated extends OnboardingState {
  OnboardingUpdated(super.index);
}

class OnboardingFinished extends OnboardingState {
  OnboardingFinished() : super(OnboardingInfo.onboardingInfo.length - 1);
}
