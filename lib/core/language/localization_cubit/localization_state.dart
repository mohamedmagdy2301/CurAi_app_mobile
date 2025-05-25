enum LocalizationStateEnum { ar, en, system }

class LocalizationState {
  LocalizationState({
    required this.locale,
  });
  final LocalizationStateEnum locale;
}
