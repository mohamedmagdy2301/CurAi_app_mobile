import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTileCard extends StatelessWidget {
  const CustomExpansionTileCard({
    required this.title,
    required this.children,
    required this.icon,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ExpansionTileCard(
            borderRadius: BorderRadius.circular(10.r),
            key: Key(title),
            title: Row(
              children: [
                Icon(
                  icon,
                  color: context.primaryColor,
                  size: 25.sp,
                ),
                15.wSpace,
                Flexible(
                  child: AutoSizeText(
                    context.translate(title),
                    maxLines: 1,
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 5),
            trailing: RotatedBox(
              quarterTurns: context.isStateArabic ? 4 : 0,
              child: Icon(
                size: 18.sp,
                Icons.arrow_forward_ios,
                color: context.primaryColor,
              ),
            ).paddingSymmetric(horizontal: constraints.maxWidth > 400 ? 10 : 0),
            baseColor: Colors.transparent,
            expandedColor: Colors.transparent,
            elevation: 0,
            children: children,
          );
        },
      ),
    );
  }
}
