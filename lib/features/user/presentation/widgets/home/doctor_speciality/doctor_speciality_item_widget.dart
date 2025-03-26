import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
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
          backgroundColor: context.onSecondaryColor.withAlpha(30),
          radius: 26,
          child: image.contains('.svg')
              ? SvgPicture.asset(
                  image,
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  image,
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                ),
        ),
        15.hSpace,
        AutoSizeText(
          context.translate(title),
          style: TextStyleApp.regular12().copyWith(
            color: context.onPrimaryColor,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
