// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

class AppointmentAvailableModel {
  AppointmentAvailableModel({this.doctorAvailability});

  AppointmentAvailableModel.fromJson(Map<String, dynamic> json) {
    if (json['doctor_availability'] != null) {
      doctorAvailability = <DoctorAvailability>[];
      json['doctor_availability'].forEach((v) {
        doctorAvailability!
            .add(DoctorAvailability.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<DoctorAvailability>? doctorAvailability;
}

class DoctorAvailability {
  DoctorAvailability({
    this.day,
    this.availableFrom,
    this.availableTo,
    this.dates,
  });

  DoctorAvailability.fromJson(Map<String, dynamic> json) {
    day = json['day'] as String;
    availableFrom = json['available_from'] as String;
    availableTo = json['available_to'] as String;
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(Dates.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? day;
  String? availableFrom;
  String? availableTo;
  List<Dates>? dates;
}

class Dates {
  Dates({this.date, this.bookedSlots, this.freeSlots});

  Dates.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String;
    bookedSlots = json['booked_slots'].cast<String>() as List<String>;
    freeSlots = json['free_slots'].cast<String>() as List<String>;
  }
  String? date;
  List<String>? bookedSlots;
  List<String>? freeSlots;
}
