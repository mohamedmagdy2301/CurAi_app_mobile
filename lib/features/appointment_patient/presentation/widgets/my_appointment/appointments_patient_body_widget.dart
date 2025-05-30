import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/build_appointments_listview.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/build_appointments_patient_empty_listview.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/build_appointments_patient_error_widget.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/my_appointment/my_appointment_patient_loading_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class AppointmentsPatientBodyWidget extends StatefulWidget {
  const AppointmentsPatientBodyWidget({required this.isPending, super.key});
  final bool isPending;

  @override
  State<AppointmentsPatientBodyWidget> createState() =>
      _AppointmentsPatientBodyWidgetState();
}

class _AppointmentsPatientBodyWidgetState
    extends State<AppointmentsPatientBodyWidget> {
  final ScrollController _scrollController = ScrollController();
  late AppointmentPatientCubit cubit;

  bool isLoadingMore = false;
  bool hasFetchedInitialData = false;

  @override

  ///
  void initState() {
    super.initState();
    cubit = context.read<AppointmentPatientCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initialLoad();
        _scrollController.addListener(_scrollListener);
      }
    });
  }

  Future<void> _initialLoad() async {
    final appointments =
        widget.isPending ? cubit.pendingAppointments : cubit.paidAppointments;

    if (appointments.isEmpty && !hasFetchedInitialData) {
      hasFetchedInitialData = true;
      await cubit.refreshMyAppointmentPatient();
    }
  }

  Future<void> _scrollListener() async {
    if (!mounted || isLoadingMore || cubit.isLast) {
      return;
    }

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent * 0.85) {
      setState(() => isLoadingMore = true);
      await cubit.getMyAppointmentPatient();
      if (mounted) setState(() => isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
      buildWhen: (previous, current) =>
          current is GetMyAppointmentPatientFailure ||
          current is GetMyAppointmentPatientSuccess ||
          current is GetMyAppointmentPatientLoading ||
          current is GetMyAppointmentPatientPaginationFailure ||
          current is GetMyAppointmentPatientPaginationLoading,
      listenWhen: (previous, current) =>
          current is GetMyAppointmentPatientFailure ||
          current is GetMyAppointmentPatientSuccess ||
          current is GetMyAppointmentPatientLoading ||
          current is GetMyAppointmentPatientPaginationFailure ||
          current is GetMyAppointmentPatientPaginationLoading,
      listener: (context, state) async {
        final appointments = widget.isPending
            ? cubit.pendingAppointments
            : cubit.paidAppointments;

        if (state is GetMyAppointmentPatientSuccess &&
            appointments.isEmpty &&
            !cubit.isLast) {
          setState(() => isLoadingMore = true);
          await cubit.getMyAppointmentPatient();
          if (mounted) setState(() => isLoadingMore = false);
        }

        if (state is GetMyAppointmentPatientFailure) {
          if (!context.mounted) return;
          showMessage(
            context,
            type: ToastificationType.error,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final appointments = widget.isPending
            ? cubit.pendingAppointments
            : cubit.paidAppointments;

        if (state is GetMyAppointmentPatientLoading) {
          return const MyAppointmentCardLoadingList();
        } else if (state is GetMyAppointmentPatientFailure) {
          return BuildAppointmentsPatientErrorWidget(state: state);
        } else if (appointments.isEmpty && cubit.isLast) {
          return BuildAppointmentsPatientEmptyList(isPending: widget.isPending);
        } else if (appointments.isNotEmpty) {
          return BuildAppointmentsList(
            cubit: cubit,
            isPending: widget.isPending,
            appointments: appointments,
            isLoadingMore: isLoadingMore,
            scrollController: _scrollController,
          );
        }
        return const MyAppointmentCardLoadingList();
      },
    );
  }
}
