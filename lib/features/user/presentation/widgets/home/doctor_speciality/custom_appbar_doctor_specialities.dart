import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:flutter/material.dart';

class CustomAppBarDoctorSpecialities extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarDoctorSpecialities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(),
      title: AutoSizeText(
        context.translate(LangKeys.doctorSpeciality),
        maxLines: 1,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
