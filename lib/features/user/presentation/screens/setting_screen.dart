// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/colors_palette_widget.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/localize_widget.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/theme_widget.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/logout_widget.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int badgeIconNumber = 0;
  String currentIconName = '?';
  bool showAlert = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeIconSettings();
  // }

  // Future<void> _initializeIconSettings() async {
  //   try {
  //     // badgeIconNumber =
  //     //     await FlutterDynamicIcon.getApplicationIconBadgeNumber();
  //     // currentIconName =
  //     //     await FlutterDynamicIcon.getAlternateIconName() ?? 'light';
  //     // setState(() {});
  //   } catch (e) {
  //     LoggerHelper.error('Error initializing icon settings', error: e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate(LangKeys.settings)),
        centerTitle: true,
        flexibleSpace: Container(color: context.color.surface),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            _buildGeneralSettingsSection(context),
            _buildthemeSection(context, cubit, state),
            _buildLocalizeSection(context, cubit, state),
            _buildColorPalettteSection(context, cubit, state),
            const LogoutWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettingsSection(BuildContext context) {
    return _buildSection(
      context,
      title: context.isStateArabic ? 'الاعــدادات العامة' : 'General Settings',
      children: [
        _buildBadgeNotificationTile(context, increase: true),
        _buildDivider(),
        _buildBadgeNotificationTile(context, increase: false),
        _buildDivider(),
        _buildListTile(
          context,
          icon: Icons.login,
          title: AppLocalizations.of(context)!.translate(LangKeys.login)!,
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          ),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildthemeSection(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    return _buildSection(
      context,
      title: context.translate(LangKeys.theme),
      children: [
        ThemeWidget(cubit: cubit, state: state),
      ],
    );
  }

  Widget _buildLocalizeSection(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    return _buildSection(
      context,
      title: context.translate(LangKeys.language),
      children: [
        LocalizeWidget(cubit: cubit, state: state),
      ],
    );
  }

  Widget _buildColorPalettteSection(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    return _buildSection(
      context,
      title: context.isStateArabic ? 'لوحة الألوان' : 'Color Palette',
      children: [
        context.spaceHeight(20),
        const ColorPaletteWidget(),
      ],
    );
  }

  Widget _buildBadgeNotificationTile(
    BuildContext context, {
    required bool increase,
  }) {
    return _buildListTile(
      context,
      icon: increase ? Icons.notifications : Icons.notifications_off_outlined,
      title: context.isStateArabic
          ? (increase ? 'اضافة الأشعـــارات' : 'حذف الأشعـــارات')
          : (increase ? 'Add Notifications' : 'Remove Notifications'),
      onTap: () async {
        try {
          badgeIconNumber = increase ? badgeIconNumber + 1 : 0;
          if (mounted) {
            _showSnackbar(
              context,
              true,
              increase ? 'Badge added' : 'Badge removed',
            );
          }
        } catch (e) {
          if (mounted) _showSnackbar(context, false, 'Failed to update badge');
        }
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTileCard(
        title: Text(title, style: context.styleSemiBold16),
        trailing: RotatedBox(
          quarterTurns: context.isStateArabic ? 3 : 1,
          child: Icon(
            size: context.setSp(15),
            Icons.arrow_forward_ios,
            color: context.color.onSurface,
          ),
        ),
        animateTrailing: true,
        baseColor: Colors.transparent,
        expandedColor: Colors.transparent,
        elevation: 0,
        children: children,
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: context.color.primary),
      title: Text(title, style: context.styleRegular14),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildDivider() => const Divider(thickness: 0.2);

  void _showSnackbar(BuildContext context, bool success, String message) {
    showMessage(
      context,
      type: success ? SnackBarType.success : SnackBarType.error,
      message: message,
    );
  }
}

// Widget _buildAppIconChangeTile(BuildContext context) {
//   return _buildListTile(
//     context,
//     icon: Icons.launch,
//     title: context.isStateArabic ? 'تغيير ايقونة التطبيق' : 'Change App Icon',
//     trailing: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildIconChangeButton(
//           context,
//           'light',
//           'assets/images/splash_light.png',
//         ),
//     context.spaceWidth(10),
//         _buildIconChangeButton(
//           context,
//           'dark',
//           'assets/images/splash_dark.png',
//         ),
//       ],
//     ),
//   );
// }
//   Widget _buildIconChangeButton(
//     BuildContext context,
//     String imageName,
//     String image,
//   ) {
//     return GestureDetector(
//       onTap: () async {
//         try {
//           // if (await FlutterDynamicIcon.supportsAlternateIcons) {
//           //   await FlutterDynamicIcon.setAlternateIconName(
//           //     imageName,
//           //     showAlert: showAlert,
//           //   );
//           //   _showSnackbar(context, true, 'App icon changed successfully');
//           //   currentIconName =
//           //       await FlutterDynamicIcon.getAlternateIconName() ?? 'light';
//           //   setState(() {});
//           // }
//         } catch (e) {
//           LoggerHelper.error('Error changing app icon', error: e);
//           _showSnackbar(context, false, 'Failed to change app icon');
//         }
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.asset(image, height: 50, width: 50),
//       ),
//     );
//   }
