import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAppointmentsPatientErrorWidget extends StatelessWidget {
  const BuildAppointmentsPatientErrorWidget({required this.state, super.key});

  final GetMyAppointmentPatientFailure state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 150.sp,
            color: Colors.redAccent,
          ),
          50.hSpace,
          AutoSizeText(
            state.message,
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.semiBold18().copyWith(
              color: Colors.redAccent.shade100,
            ),
          ),
          56.hSpace,
          CustomButton(
            title: LangKeys.tryAgain,
            onPressed: () => context
                .read<AppointmentPatientCubit>()
                .getMyAppointmentPatient(page: 1),
          ).paddingSymmetric(horizontal: 40),
        ],
      ),
    );
  }
}
