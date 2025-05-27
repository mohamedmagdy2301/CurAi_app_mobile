// import 'dart:io';

import 'dart:io';

import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension LocalizationContextExtansions on BuildContext {
  // ! System Locale
  bool get isSystemArabic => Platform.localeName.split('_').first == 'ar';

  // ! Localization Cubit
  LocalizationState get localizationState => read<LocalizationCubit>().state;
  LocalizationCubit get localizationCubit => read<LocalizationCubit>();

  bool get isStateArabic {
    switch (localizationCubit.getLocaleFromState(localizationState.locale)) {
      case const Locale('ar'):
        return true;
      case const Locale('en'):
        return false;
      default:
        return isSystemArabic;
    }
  }

  //! Localization translation
  String translate(String langKey) =>
      AppLocalizations.of(this)!.translate(langKey).toString();

//   //! Theme
//   MyAssets get assets => Theme.of(this).extension<MyAssets>()!;
//   MyColors get colors => Theme.of(this).extension<MyColors>()!;
//   TextTheme get textTheme => Theme.of(this).textTheme;
}
