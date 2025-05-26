import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechManager {
  factory TextToSpeechManager() {
    return _instance;
  }
  TextToSpeechManager._internal() {
    _flutterTts
      ..setStartHandler(() {
        isSpeaking.value = true;
      })
      ..setCompletionHandler(() {
        isSpeaking.value = false;
      })
      ..setErrorHandler((msg) {
        isSpeaking.value = false;
      });
  }
  final FlutterTts _flutterTts = FlutterTts();
  static final TextToSpeechManager _instance = TextToSpeechManager._internal();

  final ValueNotifier<bool> isSpeaking = ValueNotifier(false);

  String _removeSymbols(String input) {
    final regex = RegExp(r'[^\u0600-\u06FF\sA-Za-z0-9]');
    return input.replaceAll(regex, '');
  }

  Future<void> textToSpeechSpeak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.stop();
      final cleanedText = _removeSymbols(text);
      if (cleanedText.isEmpty) return;

      if (cleanedText.isArabicFormat) {
        await _flutterTts.setLanguage('ar-EG');
      } else {
        await _flutterTts.setLanguage('en-US');
      }
      await _flutterTts.setPitch(1);
      await _flutterTts.setVolume(1);
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.speak(cleanedText);
    }
  }

  Future<void> textToSpeechStop() async {
    await _flutterTts.stop();
    isSpeaking.value = false;
  }

  Future<void> textToSpeechPause() async {
    await _flutterTts.pause();
    isSpeaking.value = false;
  }

  Future<void> toggleSpeech(String text) async {
    if (isSpeaking.value) {
      await textToSpeechStop();
    } else {
      await textToSpeechSpeak(text);
    }
  }
}
