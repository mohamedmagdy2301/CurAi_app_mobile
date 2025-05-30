class MyAppointmentPatientModel {
  MyAppointmentPatientModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  MyAppointmentPatientModel.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'] as String? ?? '';
    if (json['results'] != null) {
      results = <ResultsMyAppointmentPatient>[];
      for (final v in (json['results'] as List)) {
        results!.add(
          ResultsMyAppointmentPatient.fromJson(v as Map<String, dynamic>),
        );
      }
    }
  }

  int? count;
  String? next;
  String? previous;
  List<ResultsMyAppointmentPatient>? results;

  List<ResultsMyAppointmentPatient> get pendingAppointments {
    return results
            ?.where((appointment) => appointment.paymentStatus == 'pending')
            .toList() ??
        [];
  }

  List<ResultsMyAppointmentPatient> get paidAppointments {
    return results
            ?.where((appointment) => appointment.paymentStatus == 'paid')
            .toList() ??
        [];
  }
}

class ResultsMyAppointmentPatient {
  ResultsMyAppointmentPatient({
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

  ResultsMyAppointmentPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    patient = json['patient'] as String?;
    patientPicture = json['patient_picture'] as String?;
    doctor = json['doctor'] as String?;
    doctorId = json['doctor_id'] as int?;
    status = json['status'] as String?;
    paymentStatus = json['payment_status'] as String?;
    appointmentDate = json['appointment_date'] as String?;
    appointmentTime = json['appointment_time'] as String?;
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

List<ResultsMyAppointmentPatient> dummyMyAppointments = [
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'pending',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'pending',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
  ResultsMyAppointmentPatient(
    id: 1,
    doctorId: 22,
    appointmentDate: DateTime.now().add(const Duration(days: 1)).toString(),
    appointmentTime: '10:00 AM',
    status: 'completed',
    doctor: 'absmnbsd jhabskjb',
    patient: 'asnbmnd basc',
    patientPicture: 'https://via.placeholder.com/150',
    paymentStatus: 'paid',
  ),
];
