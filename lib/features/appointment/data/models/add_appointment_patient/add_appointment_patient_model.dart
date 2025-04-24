class AddAppointmentPatientModel {
  AddAppointmentPatientModel({this.message, this.appointmentId});

  AddAppointmentPatientModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    appointmentId = json['appointment_id'] as int?;
  }
  String? message;
  int? appointmentId;
}

// {
//     "message": "Appointment booked successfully."
//                "Please complete the payment to confirm.",
//     "appointment_id": 24
// }
