import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/build_appointments_empty_listview.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/build_appointments_error_widget.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/build_appointments_listview.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingBodyWidget extends StatefulWidget {
  const PendingBodyWidget({super.key});

  @override
  State<PendingBodyWidget> createState() => _PendingBodyWidgetState();
}

class _PendingBodyWidgetState extends State<PendingBodyWidget> {
  final ScrollController _scrollController = ScrollController();
  late AppointmentPatientCubit cubit;

  bool isLoadingMore = false;
  bool hasFetchedInitialData = false;

  @override
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
    if (cubit.pendingAppointments.isEmpty && !hasFetchedInitialData) {
      hasFetchedInitialData = true;
      await cubit.getMyAppointmentPatient(page: 1);
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
    // if (cubit.pendingAppointments.isEmpty) {
    //   setState(() => isLoadingMore = true);
    //   await cubit.getMyAppointmentPatient();
    //   if (mounted) setState(() => isLoadingMore = false);
    // }
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
        if (state is GetMyAppointmentPatientSuccess &&
            cubit.pendingAppointments.isEmpty) {
          setState(() => isLoadingMore = true);
          await cubit.getMyAppointmentPatient();
          if (mounted) setState(() => isLoadingMore = false);
        }

        if (state is GetMyAppointmentPatientFailure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AppointmentPatientCubit>();
        final appointments = cubit.pendingAppointments;

        if (state is GetMyAppointmentPatientLoading) {
          return const MyAppointmentCardLoadingList();
        } else if (state is GetMyAppointmentPatientFailure) {
          return BuildAppointmentsErrorWidget(state: state);
        } else if (appointments.isEmpty && cubit.isLast) {
          return const BuildAppointmentsEmptyList();
        } else if (state is GetMyAppointmentPatientSuccess &&
            cubit.pendingAppointments.isNotEmpty) {
          return BuildAppointmentsList(
            cubit: cubit,
            isPending: true,
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
