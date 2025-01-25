import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAuthWithSocial extends StatelessWidget {
  const IconAuthWithSocial({required this.icon, super.key});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushReplacementNamed(Routes.mainScaffoldUser);
      },
      child: CircleAvatar(
        backgroundColor: context.color.onSecondary.withAlpha(30),
        radius: context.setR(25),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
