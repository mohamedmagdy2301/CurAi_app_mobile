import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/payment_appointment/custom_appbar_payment_appointment.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentAppointmentScreen extends StatefulWidget {
  const PaymentAppointmentScreen({
    required this.doctorResults,
    required this.appointmentId,
    super.key,
  });
  final DoctorResults doctorResults;
  final int appointmentId;

  @override
  State<PaymentAppointmentScreen> createState() =>
      _PaymentAppointmentScreenState();
}

class _PaymentAppointmentScreenState extends State<PaymentAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarPaymentAppointment(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            context.translate(LangKeys.paymentMethod),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          20.hSpace,
          AutoSizeText(
            '${widget.doctorResults.firstName} ${widget.doctorResults.lastName}'
            '\n\n'
            'Appointment id ---> ${widget.appointmentId}',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.medium14().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
          30.hSpace,
          BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
            listenWhen: (previous, current) =>
                current is PaymentAppointmentFailure ||
                current is PaymentAppointmentLoading ||
                current is PaymentAppointmentSuccess,
            buildWhen: (previous, current) =>
                current is PaymentAppointmentLoading ||
                current is PaymentAppointmentSuccess ||
                current is PaymentAppointmentFailure,
            listener: (context, state) {
              if (state is PaymentAppointmentFailure) {
                Navigator.pop(context);
                showMessage(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is PaymentAppointmentSuccess) {
                Navigator.pop(context);
                showMessage(
                  context,
                  message: state.paymentAppointmentModel.message,
                  type: SnackBarType.success,
                );

                context.pushNamed(Routes.mainScaffoldUser);
              } else if (state is PaymentAppointmentLoading) {
                AdaptiveDialogs.showLoadingAlertDialog(
                  context: context,
                  title: context.translate(LangKeys.login),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                title: LangKeys.bookAppointment,
                onPressed: () {
                  context
                      .read<AppointmentPatientCubit>()
                      .simulatePaymentAppointment(
                        appointmentId: widget.appointmentId,
                      );
                },
              );
            },
          ),
        ],
      )
          .paddingSymmetric(horizontal: 15)
          .paddingOnly(bottom: Platform.isIOS ? 17 : 10),
    );
  }
}
