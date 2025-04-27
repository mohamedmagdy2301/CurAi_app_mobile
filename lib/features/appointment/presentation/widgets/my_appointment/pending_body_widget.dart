import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
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
  @override
  void initState() {
    context.read<AppointmentPatientCubit>().getMyAppointmentPatient(page: 1);
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
        if (state is GetMyAppointmentPatientSuccess) {
          final pendingList =
              context.read<AppointmentPatientCubit>().pendingAppointments;

          if (pendingList.isEmpty) {
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
            itemCount: pendingList.length,
            itemBuilder: (context, index) {
              return PendingCardItemWidget(
                pendingAppointment: pendingList[index],
              );
            },
          );
        }
        return Skeletonizer(
          effect: shimmerEffect(context),
          child: ListView.builder(
            itemCount: dummyMyAppointments.length,
            itemBuilder: (context, index) {
              return const MyAppointmentCardLoading();
            },
          ),
        );
      },
    );
  }
}
