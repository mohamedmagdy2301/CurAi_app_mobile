import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/utils/widgets/New%20folder/build_radio_listtile.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({required this.cubit, required this.state, super.key});
  final SettingsCubit cubit;
  final SettingsState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const BuildSectionTitle(title: LangKeys.theme),
        BuildRadioListTile<ThemeModeState>(
          labelKey: LangKeys.light,
          value: ThemeModeState.light,
          groupValue: state.themeMode,
          onChanged: (theme) => cubit.setTheme(theme!),
        ),
        BuildRadioListTile<ThemeModeState>(
          labelKey: LangKeys.dark,
          value: ThemeModeState.dark,
          groupValue: state.themeMode,
          onChanged: (theme) => cubit.setTheme(theme!),
        ),
        BuildRadioListTile<ThemeModeState>(
          labelKey: LangKeys.systemDefault,
          value: ThemeModeState.system,
          groupValue: state.themeMode,
          onChanged: (theme) => cubit.setTheme(theme!),
        ),
      ],
    );
  }
}
