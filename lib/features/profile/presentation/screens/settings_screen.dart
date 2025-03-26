// ignore_for_file: flutter_style_todos

import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_settings.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_expansion_tile_card.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/palette_listview_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/theme_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/localize_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen2 extends StatelessWidget {
  const SettingsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSettings(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            25.hSpace,
            RowNavigateProfileWidget(
              icon: CupertinoIcons.bell,
              title: LangKeys.notificationSettings,
              onTap: () {},
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: Icons.password,
              title: LangKeys.passwordManager,
              onTap: () => context.pushNamed(Routes.changePasswordScreen),
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: Icons.language_outlined,
              title: LangKeys.changeLanguage,
              onTap: () {
                AdaptiveDialogs.showAlertDialogWithWidget(
                  context: context,
                  title: context.translate(LangKeys.changeLanguage),
                  widget: const LocalizeWidget(),
                );
              },
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: Icons.dark_mode_outlined,
              title: LangKeys.changeTheme,
              onTap: () {
                AdaptiveDialogs.showAlertDialogWithWidget(
                  context: context,
                  title: context.translate(LangKeys.changeTheme),
                  widget: const ThemeWidget(),
                );
              },
            ),
            _buildDivider(context),
            const CustomExpansionTileCard(
              icon: Icons.color_lens,
              title: LangKeys.colorPalette,
              children: [PalettListViewWidget()],
            ),
            _buildDivider(context),
            RowNavigateProfileWidget(
              icon: Icons.delete_outline_outlined,
              title: LangKeys.deleteAccount,
              onTap: () {
                AdaptiveDialogs.showOkCancelAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.deleteAccount),
                  message: context.translate(LangKeys.deleteAccountMessage),
                );
              },
            ),
          ],
        ).center(),
      ).paddingSymmetric(horizontal: context.isLandscape ? 100 : 0),
    );
  }

  Widget _buildDivider(BuildContext context) => Divider(
        thickness: .2,
        endIndent: 30,
        indent: 30,
        height: 0,
        color: context.onSecondaryColor,
      );
}
