import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_settings.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_expansion_tile_card.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/localize_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/palette_listview_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            Row(
              children: [
                Icon(
                  Icons.dark_mode_outlined,
                  color: context.primaryColor,
                  size: 25.sp,
                ),
                15.wSpace,
                AutoSizeText(
                  context.translate(LangKeys.changeTheme),
                  maxLines: 1,
                  style: TextStyleApp.regular16().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
                const Spacer(),
                Switch.adaptive(
                  value:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                  onChanged: (_) {
                    AdaptiveTheme.of(context).toggleThemeMode();

                    CacheDataHelper.setData(
                      key: SharedPrefKey.saveThemeMode,
                      value: AdaptiveTheme.of(context).mode,
                    );
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 5),

            // _buildDivider(context),
            // RowNavigateProfileWidget(
            //   icon: Icons.dark_mode_outlined,
            //   title: LangKeys.changeTheme,
            //   onTap: () {
            //     AdaptiveDialogs.showAlertDialogWithWidget(
            //       context: context,
            //       title: context.translate(LangKeys.changeTheme),
            //       widget: const ThemeWidget(),
            //     );
            //   },
            // ),
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
