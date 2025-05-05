// ignore_for_file: lines_longer_than_80_chars

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarDetailsDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarDetailsDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        context.translate(LangKeys.doctorSpeciality),
        style: TextStyleApp.bold20().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.pop(),
      ),
      actions: [
        // IconButton(
        //   padding: EdgeInsets.zero,
        //   icon: Icon(Icons.adaptive.share),
        //   onPressed: () {},
        // ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(CupertinoIcons.heart),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
