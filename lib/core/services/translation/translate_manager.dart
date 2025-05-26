import 'dart:io';

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
    String? textToEnglish;
    try {
      await _translator.translate(text, from: ar).then((value) {
        textToEnglish = value.text;
      });
      return textToEnglish ?? text;
    } on SocketException catch (_) {
      return text;
    } on Exception catch (_) {
      return text;
    }
  }

  Future<String> translateToArabic(String text) async {
    if (text.isEmpty) return text;
    String? textToEnglish;
    try {
      await _translator.translate(text, from: en, to: ar).then((value) {
        textToEnglish = value.text;
      });
      return textToEnglish ?? text;
    } on SocketException catch (_) {
      return text;
    } on Exception catch (_) {
      return text;
    }
  }
}
