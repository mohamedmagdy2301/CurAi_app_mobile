import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class BuildEmptyReservationsDoctorWidget extends StatelessWidget {
  const BuildEmptyReservationsDoctorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'لا يوجد حجوزات',
      maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyleApp.medium28().copyWith(
        color: context.onSecondaryColor.withAlpha(80),
      ),
    );
  }
}
