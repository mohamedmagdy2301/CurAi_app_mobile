import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';

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
        return spaceHeight(isValid ? 20 : 10);
      },
    );
  }
}
