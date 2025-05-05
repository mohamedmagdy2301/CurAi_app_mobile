import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';

class CustomAppbarPaymentAppointment extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarPaymentAppointment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(LangKeys.paymentBook),
        maxLines: 1,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () =>
            context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
