import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:flutter/material.dart';

class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        appLocal.translate(title)!,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
