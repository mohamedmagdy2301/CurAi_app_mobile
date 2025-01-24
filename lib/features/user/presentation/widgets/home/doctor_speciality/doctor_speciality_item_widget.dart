import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//TODO: change color
class DoctorSpecialityItemWidget extends StatelessWidget {
  const DoctorSpecialityItemWidget({
    required this.title,
    required this.image,
    super.key,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: context.color.onSecondary.withAlpha(30),
          radius: context.setR(26),
          child: image.contains('.svg')
              ? SvgPicture.asset(
                  image,
                  height: context.setH(25),
                  width: context.setW(25),
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  image,
                  height: context.setH(25),
                  width: context.setW(25),
                  fit: BoxFit.fill,
                ),
        ),
        context.spaceHeight(15),
        AutoSizeText(
          context.translate(title),
          style: context.styleRegular12,
          maxLines: 1,
        ),
      ],
    );
  }
}
