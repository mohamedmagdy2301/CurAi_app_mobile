import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/appointments_booking_doctor/build_empty_appointments_booking_doctor_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/appointments_booking_doctor/build_error_appointments_booking_doctor_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/appointments_booking_doctor/build_success_appointments_booking_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsBookingDoctorScreen extends StatefulWidget {
  const AppointmentsBookingDoctorScreen({super.key});

  @override
  State<AppointmentsBookingDoctorScreen> createState() =>
      _AppointmentsBookingDoctorScreenState();
}

class _AppointmentsBookingDoctorScreenState
    extends State<AppointmentsBookingDoctorScreen> {
  @override
  void initState() {
    context.read<AppointmentDoctorCubit>().getAppointmentsBookingDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجوزات الطبيب'),
      ),
      body: BlocBuilder<AppointmentDoctorCubit, AppointmentDoctorState>(
        buildWhen: (previous, current) =>
            current is GetAppointmentsBookingDoctorSuccess ||
            current is GetAppointmentsBookingDoctorFailure ||
            current is GetAppointmentsBookingDoctorEmpty ||
            current is GetAppointmentsBookingDoctorLoading,
        builder: (context, state) {
          if (state is GetAppointmentsBookingDoctorSuccess) {
            return BuildSuccessAppointmentsBookingDoctorWidget(
              appointments: state.appointments,
            );
          } else if (state is GetAppointmentsBookingDoctorFailure) {
            return BuildErrorAppointmentsBookingDoctorWidget(
              message: state.message,
            );
          } else if (state is GetAppointmentsBookingDoctorEmpty) {
            return const BuildEmptyAppointmentsBookingDoctorWidget();
          }

          return CustomLoadingWidget(height: 70.h, width: 70.w).center();
        },
      ),
    );
  }
}
