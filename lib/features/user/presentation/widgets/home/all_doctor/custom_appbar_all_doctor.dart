import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class CustomAppBarAllDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarAllDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(color: context.color.surface),
      title: AutoSizeText(
        context.translate(LangKeys.doctors),
        maxLines: 1,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
