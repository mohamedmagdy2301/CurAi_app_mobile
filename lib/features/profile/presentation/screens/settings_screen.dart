import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
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
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: context.backgroundColor,
                  barrierColor: context.onPrimaryColor.withAlpha(60),
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  builder: (_) => const EnhancedLocalizeWidget(),
                );
                // AdaptiveDialogs.showAlertDialogWithWidget(
                //   context: context,
                //   title: context.translate(LangKeys.changeLanguage),
                //   widget: const EnhancedLocalizeWidget(),
                // );
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
                  padding: EdgeInsets.zero,
                  thumbIcon: WidgetStateProperty.all(
                    (_getIsDarkMode(context))
                        ? Icon(
                            CupertinoIcons.moon,
                            color: context.backgroundColor,
                          )
                        : const Icon(
                            CupertinoIcons.sun_max_fill,
                            color: Colors.amber,
                          ),
                  ),
                  activeColor: context.primaryColor,
                  inactiveTrackColor: context.onSecondaryColor,
                  thumbColor: WidgetStateProperty.all(context.onPrimaryColor),
                  value: _getIsDarkMode(context),
                  onChanged: (_) async {
                    await _toggleTheme(context);
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 5),
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
                AdaptiveDialogs.showOkCancelAlertDialog<bool>(
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

  // Helper method to check if dark mode is enabled
  bool _getIsDarkMode(BuildContext context) {
    final themeMode = AdaptiveTheme.of(context).mode;
    return themeMode == AdaptiveThemeMode.dark ||
        (themeMode == AdaptiveThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
  }

  // Helper method to toggle between dark and light mode
  Future<void> _toggleTheme(BuildContext context) async {
    final currentMode = AdaptiveTheme.of(context).mode;
    final newMode = currentMode == AdaptiveThemeMode.dark
        ? AdaptiveThemeMode.light
        : AdaptiveThemeMode.dark;

    AdaptiveTheme.of(context).setThemeMode(newMode);
    await di.sl<CacheDataManager>().setData(
          key: SharedPrefKey.saveThemeMode,
          value: newMode.name,
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
