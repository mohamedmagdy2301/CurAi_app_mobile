import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class HeightValidNotifier extends StatelessWidget {
  const HeightValidNotifier({
    required this.isFormValidNotifier,
    super.key,
  });

  final ValueNotifier<bool> isFormValidNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFormValidNotifier,
      builder: (context, isValid, child) {
        return isValid ? 14.hSpace : 10.hSpace;
      },
    );
  }
}
