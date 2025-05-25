import 'package:curai_app_mobile/features/onboarding/data/model/onboarding_model.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';

class OnboardingInfo {
  static List<OnboardingModel> onboardingInfo = [
    const OnboardingModel(
      image: AppImages.onboardingDoctor1,
      title: LangKeys.titleOnboarding1,
      body: LangKeys.descriptionOnboarding1,
      index: 0,
    ),
    const OnboardingModel(
      image: AppImages.onboardingDoctor2,
      title: LangKeys.titleOnboarding2,
      body: LangKeys.descriptionOnboarding2,
      index: 1,
    ),
    const OnboardingModel(
      image: AppImages.onboardingDoctor3,
      title: LangKeys.titleOnboarding3,
      body: LangKeys.descriptionOnboarding3,
      index: 2,
    ),
    const OnboardingModel(
      image: AppImages.onboardingDoctor4,
      title: LangKeys.titleOnboarding4,
      body: LangKeys.descriptionOnboarding4,
      index: 3,
    ),
  ];
}
