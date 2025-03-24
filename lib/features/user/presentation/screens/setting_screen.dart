// ignore_for_file: inference_failure_on_instance_creation,, document_ignores
// use_build_context_synchronously, avoid_catches_without_on_clauses
import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/localization_state.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/change_password/change_password_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/logout_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/screens/appreance_screen.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/localize_widget.dart';
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
  //       badgeIconNumber =
  //           await FlutterDynamicIcon.getApplicationIconBadgeNumber();
  //       currentIconName =
  //           await FlutterDynamicIcon.getAlternateIconName() ?? 'light';
  //       setState(() {});
  //   } catch (e) {
  //     LoggerHelper.error('Error initializing icon settings', error: e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocalizationCubit>();
    final state = context.watch<LocalizationCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate(LangKeys.settings)),
        centerTitle: true,
        flexibleSpace: Container(color: context.backgroundColor),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            _buildGeneralSettingsSection(context),
            _buildDivider(),
            const AppreanceScreen(),
            _buildDivider(),
            _buildLocalizeSection(context, cubit, state),
            _buildDivider(),
            const ChangePasswordWidget(),
            _buildDivider(),
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

  Widget _buildLocalizeSection(
    BuildContext context,
    LocalizationCubit cubit,
    LocalizationState state,
  ) {
    return _buildSection(
      context,
      title: context.translate(LangKeys.language),
      children: [
        const LocalizeWidget(),
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
        title: Text(title, style: TextStyleApp.semiBold16()),
        trailing: RotatedBox(
          quarterTurns: context.isStateArabic ? 3 : 1,
          child: Icon(
            size: 15,
            Icons.arrow_forward_ios,
            color: context.onPrimaryColor,
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
      leading: Icon(icon, color: context.backgroundColor),
      title: Text(title, style: TextStyleApp.regular14()),
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
