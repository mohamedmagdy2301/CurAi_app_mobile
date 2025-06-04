class PatientHistoryModel {
  PatientHistoryModel({
    required this.id,
    required this.doctor,
    required this.notes,
    required this.createdAt,
    required this.doctorUsername,
    required this.patientUsername,
  });

  factory PatientHistoryModel.fromJson(Map<String, dynamic> json) {
    return PatientHistoryModel(
      id: json['id'] as int,
      doctor: json['doctor'] as int,
      notes: json['notes'] as String,
      createdAt: json['created_at'] as String,
      doctorUsername: json['doctor_username'] as String,
      patientUsername: json['patient_username'] as String,
    );
  }
  final int id;
  final int doctor;
  final String? notes;
  final String createdAt;
  final String doctorUsername;
  final String patientUsername;
}
