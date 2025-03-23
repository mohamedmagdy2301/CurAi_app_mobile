// ignore_for_file: flutter_style_todos

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';

class RowNavigateProfileWidget extends StatelessWidget {
  const RowNavigateProfileWidget({
    required this.icon,
    required this.title,
    super.key,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          Icon(icon, color: context.backgroundColor),
          15.wSpace,
          AutoSizeText(
            context.translate(title),
            maxLines: 1,
            style: TextStyleApp.regular16(),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: context.backgroundColor,
          ),
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 15),
    ).paddingSymmetric(horizontal: 15);
  }
}
