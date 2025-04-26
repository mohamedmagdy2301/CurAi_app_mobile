import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/pending_card_item_widget.dart';
import 'package:flutter/material.dart';

class PendingBodyWidget extends StatelessWidget {
  const PendingBodyWidget({required this.pendingAppointmentsList, super.key});
  final List<ResultsMyAppointmentPatient> pendingAppointmentsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pendingAppointmentsList.length,
      itemBuilder: (context, index) {
        return PendingCardItemWidget(
          pendingAppointment: pendingAppointmentsList[index],
        );
      },
    );
  }
}
