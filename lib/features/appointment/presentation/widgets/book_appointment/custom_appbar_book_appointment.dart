import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class CustomAppbarBookAppointment extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarBookAppointment({
    required this.isReschedule,
    super.key,
  });
  final bool isReschedule;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(
          isReschedule ? LangKeys.reschedule : LangKeys.bookAppointment,
        ),
        maxLines: 1,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
