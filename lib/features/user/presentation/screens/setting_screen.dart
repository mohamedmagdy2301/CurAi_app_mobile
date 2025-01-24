// ignore_for_file: inference_failure_on_instance_creation, use_build_context_synchronously, avoid_catches_without_on_clauses

import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/colors_palette_widget.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/localize_widget.dart';
import 'package:curai_app_mobile/core/common/widgets/New%20folder/theme_widget.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
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
        title: Text(context.isStateArabic ? 'الأعـــــدادات' : 'Settings'),
        centerTitle: true,
        flexibleSpace: Container(color: context.color.surface),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            _buildGeneralSettingsSection(context),
            _buildAppearanceSection(context, cubit, state),
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
      ],
    );
  }

  Widget _buildAppearanceSection(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    return _buildSection(
      context,
      title: context.isStateArabic ? 'المظهر' : 'Appearance',
      children: [
        ThemeWidget(cubit: cubit, state: state),
        const Divider(),
        LocalizeWidget(cubit: cubit, state: state),
        const Divider(),
        const SizedBox(height: 20),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ExpansionTileCard(
        baseColor: Theme.of(context).cardColor,
        expandedColor: Theme.of(context).cardColor,
        elevation: 0,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
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
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildDivider() => const Divider(thickness: 0.5);

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
//         spaceWidth(10),
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
