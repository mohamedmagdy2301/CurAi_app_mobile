import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class CustemButton extends StatelessWidget {
  const CustemButton({
    required this.title,
    super.key,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: onPressed,
      child: Text(
        context.translate(title),
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeightHelper.medium,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
