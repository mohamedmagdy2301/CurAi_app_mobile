import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
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
    final appLocal = AppLocalizations.of(context)!;
    return RadioListTile<T>(
      title: Text(
        appLocal.translate(labelKey)!,
        style: context.styleRegular14,
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
