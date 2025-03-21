import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/utils/widgets/New%20folder/build_radio_listtile.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class LocalizeWidget extends StatelessWidget {
  const LocalizeWidget({required this.cubit, required this.state, super.key});
  final SettingsCubit cubit;
  final SettingsState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildRadioListTile<LocalizationState>(
          labelKey: LangKeys.english,
          value: LocalizationState.en,
          groupValue: state.locale,
          onChanged: (locale) => cubit.setLocale(locale!),
        ),
        BuildRadioListTile<LocalizationState>(
          labelKey: LangKeys.arabic,
          value: LocalizationState.ar,
          groupValue: state.locale,
          onChanged: (locale) => cubit.setLocale(locale!),
        ),
        BuildRadioListTile<LocalizationState>(
          labelKey: LangKeys.systemDefault,
          value: LocalizationState.system,
          groupValue: state.locale,
          onChanged: (locale) => cubit.setLocale(locale!),
        ),
      ],
    );
  }
}
