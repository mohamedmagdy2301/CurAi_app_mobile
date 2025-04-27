import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/pending_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PendingBodyWidget extends StatefulWidget {
  const PendingBodyWidget({super.key});

  @override
  State<PendingBodyWidget> createState() => _PendingBodyWidgetState();
}

class _PendingBodyWidgetState extends State<PendingBodyWidget> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<AppointmentPatientCubit>().getMyAppointmentPatient(page: 1);
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = context.read<AppointmentPatientCubit>();

      if (!isLoadingMore && !cubit.isLast) {
        setState(() => isLoadingMore = true);
        await cubit.getMyAppointmentPatient();
        setState(() => isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
      listener: (context, state) {
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

        if (state is GetMyAppointmentPatientLoading &&
            cubit.pendingAppointments.isEmpty) {
          return Skeletonizer(
            effect: shimmerEffect(context),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) => const MyAppointmentCardLoading(),
            ),
          );
        } else if (state is GetMyAppointmentPatientFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, size: 80, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => cubit.getMyAppointmentPatient(page: 1),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else if (cubit.pendingAppointments.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.event_busy, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('لا يوجد مواعيد حالياً', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: cubit.pendingAppointments.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < cubit.pendingAppointments.length) {
              return PendingCardItemWidget(
                pendingAppointment: cubit.pendingAppointments[index],
              );
            }
            return const MyAppointmentCardLoading();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
