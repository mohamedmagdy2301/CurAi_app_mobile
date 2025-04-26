class MyAppointmentModel {
  MyAppointmentModel({this.count, this.next, this.previous, this.results});

  MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int;
    next = json['next'] as String;
    previous = json['previous'] as String? ?? '';
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? count;
  String? next;
  String? previous;

  List<Results>? results;
}

class Results {
  Results({
    this.id,
    this.patient,
    this.patientPicture,
    this.doctor,
    this.doctorId,
    this.status,
    this.paymentStatus,
    this.appointmentDate,
    this.appointmentTime,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    patient = json['patient'] as String;
    patientPicture = json['patient_picture'] as String;
    doctor = json['doctor'] as String;
    doctorId = json['doctor_id'] as int;
    status = json['status'] as String;
    paymentStatus = json['payment_status'] as String;
    appointmentDate = json['appointment_date'] as String;
    appointmentTime = json['appointment_time'] as String;
  }
  int? id;
  String? patient;
  String? patientPicture;
  String? doctor;
  int? doctorId;
  String? status;
  String? paymentStatus;
  String? appointmentDate;
  String? appointmentTime;
}
