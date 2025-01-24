import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
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
        return context.spaceHeight(isValid ? 20 : 10);
      },
    );
  }
}
