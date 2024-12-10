// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curai_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/app_localizations.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/register_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = AppLocalizations.of(context)!.isEnglishLocale;
    final isDarkMode = context.read<AppCubit>().isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic() ? 'الأعـــــدادات' : 'Settings',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            // Language Section
            _buildSectionTitle(
              context,
              isArabic() ? 'الاعــدادات العامة' : 'General Settings',
            ),
            spaceHeight(10),
            _buildListTile(
              context,
              icon: Icons.language,
              title: AppLocalizations.of(context)!
                  .translate(LangKeys.changeLanguage),
              trailing: Switch(
                value: isEnglish,
                onChanged: (value) {
                  if (value) {
                    context.read<AppCubit>().toEnglish();
                  } else {
                    context.read<AppCubit>().toArabic();
                  }
                },
              ),
            ),
            const Divider(thickness: .5),
            _buildListTile(
              context,
              icon: Icons.brightness_6,
              title:
                  AppLocalizations.of(context)!.translate(LangKeys.changeTheme),
              trailing: Switch.adaptive(
                value: isDarkMode,
                onChanged: (value) {
                  context.read<AppCubit>().changeTheme();
                },
              ),
            ),
            const Divider(thickness: .5),
            _buildListTile(
              context,
              icon: Icons.notifications,
              title: isArabic() ? 'عـرض الأشعـــارات' : 'Show Notifections',
              onTap: () {
                showMessage(
                  context,
                  type: SnackBarType.success,
                  message: isEnglish ? 'Notifecation' : 'اشعــــــار',
                );
              },
            ),
            const Divider(thickness: .5),
            _buildListTile(
              context,
              title: 'Logout',
              icon: Icons.logout,
              onTap: () => context.pushNamed(Routes.loginScreen),
            ),
            const Divider(thickness: .5),
            _buildListTile(
              context,
              icon: Icons.login,
              title: AppLocalizations.of(context)!.translate(LangKeys.login),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title ?? '',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String? title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
