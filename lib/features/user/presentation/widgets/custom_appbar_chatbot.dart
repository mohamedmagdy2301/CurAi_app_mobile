import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:flutter/material.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.appBarHome,
      elevation: 0,
      flexibleSpace: Container(color: context.colors.appBarHome),
      title: Text(
        isArabic() ? 'الدردشــة' : 'ChatBot',
        style: context.textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeightHelper.extraBold,
          color: context.colors.bodyTextOnboarding,
        ),
      ),
      iconTheme: IconThemeData(color: context.colors.bodyTextOnboarding),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
