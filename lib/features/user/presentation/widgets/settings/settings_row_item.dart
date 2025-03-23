import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsRowItem extends StatelessWidget {
  const SettingsRowItem({
    required this.title,
    required this.leading,
    super.key,
  });
  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          color: context.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyleApp.regular20().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              const Spacer(),
              leading,
            ],
          ),
        ),
        Divider(
          color: context.onPrimaryColor.withAlpha(120),
          thickness: .5,
          height: 0,
        ),
      ],
    );
  }
}
