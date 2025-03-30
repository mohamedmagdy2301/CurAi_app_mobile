import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/rateing_doctor_widget.dart';
import 'package:flutter/material.dart';

class DateDoctorWidget extends StatelessWidget {
  const DateDoctorWidget({
    required this.doctorModel,
    super.key,
  });

  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.W * .45,
          child: AutoSizeText(
            context.translate(doctorModel.specialty),
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium14().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
        ),
        RateingDoctorWidget(doctorModel: doctorModel),
      ],
    );
  }
}
