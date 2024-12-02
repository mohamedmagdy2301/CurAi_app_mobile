import 'package:smartcare_app_mobile/core/app/onboarding/data/model/onboarding_model.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/styles/images/app_images.dart';

class OnboardingInfo {
  static List<OnboardingModel> onboardingInfo = [
    OnboardingModel(
      image: AppImages.onboardingDoctor1,
      title: LangKeys.titleOnboarding1,
      body: LangKeys.descraptionOnboarding1,
      index: 0,
    ),
    OnboardingModel(
      image: AppImages.onboardingDoctor1,
      title: LangKeys.titleOnboarding2,
      body: LangKeys.descraptionOnboarding2,
      index: 1,
    ),
    OnboardingModel(
      image: AppImages.onboardingDoctor1,
      title: LangKeys.titleOnboarding3,
      body: LangKeys.descraptionOnboarding3,
      index: 2,
    ),
  ];
}
