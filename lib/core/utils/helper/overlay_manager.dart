import 'package:flutter/material.dart';

class OverlayManager {
  static OverlayEntry? _activeOverlay;

  static void showOverlay(OverlayEntry entry, BuildContext context) {
    removeOverlay();
    Overlay.of(context).insert(entry);
    _activeOverlay = entry;
  }

  static void removeOverlay() {
    _activeOverlay?.remove();
    _activeOverlay = null;
  }

  static bool get isOverlayVisible => _activeOverlay != null;
}
