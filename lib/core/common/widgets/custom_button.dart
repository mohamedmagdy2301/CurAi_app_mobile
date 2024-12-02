import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

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
