class ReservationsDoctorModel {
  ReservationsDoctorModel({
    required this.id,
    required this.patient,
    required this.patientId,
    required this.patientPicture,
    required this.doctor,
    required this.doctorId,
    required this.status,
    required this.paymentStatus,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory ReservationsDoctorModel.fromJson(Map<String, dynamic> json) {
    return ReservationsDoctorModel(
      id: json['id'] as int,
      patient: json['patient'] as String,
      patientId: json['patient_id'] as int,
      patientPicture: json['patient_picture'] as String,
      doctor: json['doctor'] as String,
      doctorId: json['doctor_id'] as int,
      status: json['status'] as String,
      paymentStatus: json['payment_status'] as String,
      appointmentDate: json['appointment_date'] as String,
      appointmentTime: json['appointment_time'] as String,
    );
  }
  final int id;
  final String patient;
  final int patientId;
  final String? patientPicture;
  final String doctor;
  final int doctorId;
  final String status;
  final String paymentStatus;
  final String appointmentDate;
  final String appointmentTime;
}
