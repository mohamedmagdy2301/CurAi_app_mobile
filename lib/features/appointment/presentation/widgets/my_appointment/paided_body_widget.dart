import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/paided_card_item_widget.dart';
import 'package:flutter/material.dart';

class PaidedBodyWidget extends StatelessWidget {
  const PaidedBodyWidget({required this.paidAppointmentsList, super.key});
  final List<ResultsMyAppointmentPatient> paidAppointmentsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: paidAppointmentsList.length,
      itemBuilder: (context, index) {
        return PaidedCardItemWidget(
          paidAppointment: paidAppointmentsList[index],
        );
      },
    );
  }
}
