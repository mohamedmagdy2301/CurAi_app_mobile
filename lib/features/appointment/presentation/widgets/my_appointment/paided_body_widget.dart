import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/my_appointment_loading_card.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/paided_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaidedBodyWidget extends StatefulWidget {
  const PaidedBodyWidget({super.key});

  @override
  State<PaidedBodyWidget> createState() => _PaidedBodyWidgetState();
}

class _PaidedBodyWidgetState extends State<PaidedBodyWidget> {
  @override
  void initState() {
    context.read<AppointmentPatientCubit>().getMyAppointmentPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentPatientCubit, AppointmentPatientState>(
      buildWhen: (previous, current) =>
          current is GetMyAppointmentPatientFailure ||
          current is GetMyAppointmentPatientSuccess ||
          current is GetMyAppointmentPatientLoading,
      builder: (context, state) {
        if (state is GetMyAppointmentPatientFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, size: 80, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AppointmentPatientCubit>()
                        .getMyAppointmentPatient();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else if (state is GetMyAppointmentPatientSuccess) {
          final paidAppointmentList =
              context.read<AppointmentPatientCubit>().paidAppointments;

          if (paidAppointmentList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event_busy, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'لا يوجد مواعيد حالياً',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: paidAppointmentList.length,
            itemBuilder: (context, index) {
              return PaidedCardItemWidget(
                paidAppointment: paidAppointmentList[index],
              );
            },
          );
        }
        return Skeletonizer(
          effect: shimmerEffect(context),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const MyAppointmentCardLoading();
            },
          ),
        );
      },
    );
  }
}
