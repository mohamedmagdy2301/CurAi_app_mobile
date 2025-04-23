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

class MergedDateAvailability {
  MergedDateAvailability({
    required this.day,
    required this.dateString,
    required this.date,
    required this.availableFrom,
    required this.availableTo,
    required this.freeSlots,
  });
  final String day;
  final String dateString;
  final DateTime date;
  final String availableFrom;
  final String availableTo;
  final List<String> freeSlots;
}

List<MergedDateAvailability> mergeAndSortByDate(
  AppointmentAvailableModel model,
) {
  final mergedList = <MergedDateAvailability>[];

  for (final (doctor as DoctorAvailability) in model.doctorAvailability ?? []) {
    final day = doctor.day ?? '';
    final from = doctor.availableFrom ?? '';
    final to = doctor.availableTo ?? '';

    for (final (dateEntry as Dates) in doctor.dates ?? []) {
      final dateStr = dateEntry.date ?? '';
      final parsedDate = DateTime.tryParse(dateStr);
      if (parsedDate != null) {
        mergedList.add(
          MergedDateAvailability(
            day: day,
            dateString: dateStr,
            date: parsedDate,
            availableFrom: from,
            availableTo: to,
            freeSlots: dateEntry.freeSlots ?? [],
          ),
        );
      }
    }
  }

  mergedList.sort((a, b) => a.date.compareTo(b.date));
  final now = DateTime.now();

  final upcomingDates = mergedList.where((e) => !e.date.isBefore(now)).toList();

  return upcomingDates;
}
