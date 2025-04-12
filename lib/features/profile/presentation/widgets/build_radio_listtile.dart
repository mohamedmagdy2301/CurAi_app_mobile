import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class BuildRadioListTile<T> extends StatelessWidget {
  const BuildRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.labelKey,
    super.key,
  });

  final T groupValue;
  final void Function(T?) onChanged;
  final String labelKey;
  final T value;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: Text(
        context.translate(labelKey),
        style: TextStyleApp.regular14().copyWith(color: context.onPrimaryColor),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
