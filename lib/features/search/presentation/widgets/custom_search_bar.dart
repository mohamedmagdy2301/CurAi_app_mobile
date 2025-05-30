import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  SearchBarDelegate({
    required this.suffixIcon,
    required this.controller,
    required this.onChanged,
    this.onPressedSort,
  });
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final void Function()? onPressedSort;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: context.backgroundColor,
      padding: context.padding(
        horizontal: 20,
        vertical: 10,
      ),
      child: CustomTextFeild(
        labelText: context.translate(LangKeys.doctors),
        isValidator: false,
        controller: controller,
        onChanged: onChanged,
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: context.primaryColor.withAlpha(160),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            suffixIcon ?? const SizedBox.shrink(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressedSort,
              icon: Icon(
                CupertinoIcons.line_horizontal_3_decrease,
                color: context.primaryColor.withAlpha(160),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70.h;

  @override
  double get minExtent => 70.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
