import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/utils/widgets/New%20folder/colors_palette_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/New%20folder/localize_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/New%20folder/theme_widget.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen2 extends StatelessWidget {
  const SettingsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    final appLocal = AppLocalizations.of(context)!;
    cubit.loadSettings();
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocal.translate(LangKeys.settings)!),
      ),
      body: ListView(
        children: [
          ThemeWidget(cubit: cubit, state: state),
          const Divider(),
          LocalizeWidget(cubit: cubit, state: state),
          const Divider(),
          const SizedBox(height: 20),
          const ColorPaletteWidget(),
        ],
      ),
    );
  }
}
