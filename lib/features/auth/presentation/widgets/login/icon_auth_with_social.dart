import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconAuthWithSocial extends StatelessWidget {
  const IconAuthWithSocial({required this.icon, super.key});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(25.r),
      child: CircleAvatar(
        backgroundColor: context.onSecondaryColor.withAlpha(30),
        radius: 25.r,
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
