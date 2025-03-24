import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_state.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/build_radio_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizeWidget extends StatelessWidget {
  const LocalizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocalizationCubit>();
    final state = context.read<LocalizationCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildRadioListTile<LocalizationStateEnum>(
          labelKey: LangKeys.english,
          value: LocalizationStateEnum.en,
          groupValue: state.locale,
          onChanged: (locale) {
            cubit.setLocale(locale!);
            context.pop();
          },
        ),
        BuildRadioListTile<LocalizationStateEnum>(
          labelKey: LangKeys.arabic,
          value: LocalizationStateEnum.ar,
          groupValue: state.locale,
          onChanged: (locale) {
            cubit.setLocale(locale!);
            context.pop();
          },
        ),
        BuildRadioListTile<LocalizationStateEnum>(
          labelKey: LangKeys.systemDefault,
          value: LocalizationStateEnum.system,
          groupValue: state.locale,
          onChanged: (locale) {
            cubit.setLocale(locale!);
            context.pop();
          },
        ),
      ],
    );
  }
}
