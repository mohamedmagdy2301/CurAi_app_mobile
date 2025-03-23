import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class CustomAppBarProfile extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(LangKeys.profile),
        maxLines: 1,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
