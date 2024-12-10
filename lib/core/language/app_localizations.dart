import 'dart:convert' show json;

import 'package:curai_app_mobile/core/language/app_localizations_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  // Static method to retrieve the AppLocalizations instance
  // from the nearest BuildContext.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static constant that holds the delegate for this localization.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  // Map to store the localized strings.
  late Map<String, String> _localizedStrings;

  // Method to load the localized strings from JSON files.
  Future<void> load() async {
    final jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');

    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map<String, String>((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  // Method to translate a given key into the corresponding localized string.
  String? translate(String key) => _localizedStrings[key];

  // Getter method to check if the current locale is English.
  bool get isEnglishLocale => locale.languageCode == 'en';
}
