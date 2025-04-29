class ScheduleAppointmentPatientRequest {
  ScheduleAppointmentPatientRequest({
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
  });
  final String appointmentDate;
  final String appointmentTime;
  final int doctorId;

  Map<String, dynamic> toJson() {
    return {
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
    };
  }
}
// {
//   "appointment_date": "2025-04-27",
//   "appointment_time": "11:00"
// }
