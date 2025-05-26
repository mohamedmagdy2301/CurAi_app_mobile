import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/services/text_to_speech/text_to_speech_manager.dart';
import 'package:flutter/material.dart';

class OverlayManager {
  static OverlayEntry? _activeOverlay;

  static void showOverlay(OverlayEntry entry, BuildContext context) {
    removeOverlay();
    Overlay.of(context).insert(entry);
    _activeOverlay = entry;
  }

  static void removeOverlay() {
    sl<TextToSpeechManager>().textToSpeechStop();
    _activeOverlay?.remove();
    _activeOverlay = null;
  }

  static bool get isOverlayVisible => _activeOverlay != null;
}
