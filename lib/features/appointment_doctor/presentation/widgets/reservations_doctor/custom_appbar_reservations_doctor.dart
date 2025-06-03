import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomAppbarReservationsDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarReservationsDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: ListTile(
        title: AutoSizeText(
          context.isStateArabic
              ? 'مرحبا,${context.translate(LangKeys.dr)} ${getFullName()} 👋'
              : 'Hello, ${context.translate(LangKeys.dr)} ${getFullName()} 👋',
          style: TextStyleApp.extraBold20().copyWith(
            color: context.primaryColor,
          ),
          maxLines: 1,
        ),
        subtitle: AutoSizeText(
          context.translate(LangKeys.howAreYouToday),
          style: TextStyleApp.bold14().copyWith(
            color: context.onSecondaryColor.withAlpha(130),
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
