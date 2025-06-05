import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/build_empty_reservations_doctor_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/build_error_reservations_doctor_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/build_success_reservations_doctor_widget.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/reservations_doctor/custom_appbar_reservations_doctor.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/build_loading_patient_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationsDoctorScreen extends StatefulWidget {
  const ReservationsDoctorScreen({super.key});

  @override
  State<ReservationsDoctorScreen> createState() =>
      _ReservationsDoctorScreenState();
}

class _ReservationsDoctorScreenState extends State<ReservationsDoctorScreen> {
  @override
  void initState() {
    context.read<AppointmentDoctorCubit>().getReservationsDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarReservationsDoctor(),
      body: BlocBuilder<AppointmentDoctorCubit, AppointmentDoctorState>(
        buildWhen: (previous, current) =>
            current is GetReservationsDoctorSuccess ||
            current is GetReservationsDoctorFailure ||
            current is GetReservationsDoctorEmpty ||
            current is GetReservationsDoctorLoading,
        builder: (context, state) {
          if (state is GetReservationsDoctorSuccess) {
            return BuildSuccessReservationsDoctorWidget(
              appointments: state.appointments,
            );
          } else if (state is GetReservationsDoctorFailure) {
            return BuildErrorReservationsDoctorWidget(
              message: state.message,
            );
          } else if (state is GetReservationsDoctorEmpty) {
            return const BuildEmptyReservationsDoctorWidget();
          }
          return const BuildLoadingPatientHistory();
        },
      ),
    );
  }
}
