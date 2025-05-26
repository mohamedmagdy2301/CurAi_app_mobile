import 'dart:io';

import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:translator/translator.dart';

class TranslateManager {
  factory TranslateManager() => TranslateManager._instance;

  TranslateManager._privateConstructor();
  static final TranslateManager _instance =
      TranslateManager._privateConstructor();

  final _translator = GoogleTranslator();

  static const String ar = 'ar';
  static const String en = 'en';

  Future<String> translateToEnglish(String text) async {
    if (text.isEmpty) return text;
    String? translatedText;
    try {
      await _translator.translate(text, from: ar).then((value) {
        translatedText = value.text;
      });
      return translatedText ?? text;
    } on SocketException catch (_) {
      return text;
    } on Exception catch (_) {
      return text;
    }
  }

  Future<String> translateToArabic(String text) async {
    if (text.isEmpty) return text;
    String? translatedText;
    try {
      await _translator.translate(text, from: en, to: ar).then((value) {
        translatedText = value.text;
      });
      return translatedText ?? text;
    } on SocketException catch (_) {
      return text;
    } on Exception catch (_) {
      return text;
    }
  }

  Future<String> translate(
    String text,
  ) async {
    if (text.isEmpty) return text;
    String? translatedText;

    try {
      if (text.isArabicFormat) {
        await _translator.translate(text, from: ar).then((value) {
          translatedText = value.text;
        });
      } else {
        await _translator.translate(text, from: en, to: ar).then((value) {
          translatedText = value.text;
        });
      }
      return translatedText ?? text;
    } on SocketException catch (_) {
      return text;
    } on Exception catch (_) {
      return text;
    }
  }
}
