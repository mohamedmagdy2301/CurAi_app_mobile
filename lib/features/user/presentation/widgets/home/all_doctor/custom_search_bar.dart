import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  SearchBarDelegate({
    required this.suffixIcon,
    required this.controller,
    required this.onChanged,
  });
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Widget? suffixIcon;

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
        suffixIcon: suffixIcon,
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
