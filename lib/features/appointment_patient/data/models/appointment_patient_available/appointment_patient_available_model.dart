// ignore_for_file: avoid_dynamic_calls,, document_ignores
// inference_failure_on_untyped_parameter

class AppointmentPatientAvailableModel {
  AppointmentPatientAvailableModel({this.doctorAvailability});

  AppointmentPatientAvailableModel.fromJson(Map<String, dynamic> json) {
    if (json['doctor_availability'] != null) {
      doctorAvailability = <DoctorPatientAvailability>[];
      json['doctor_availability'].forEach(
        (v) => doctorAvailability!
            .add(DoctorPatientAvailability.fromJson(v as Map<String, dynamic>)),
      );
    }
  }
  List<DoctorPatientAvailability>? doctorAvailability;
}

class DoctorPatientAvailability {
  DoctorPatientAvailability({
    this.day,
    this.availableFrom,
    this.availableTo,
    this.dates,
  });

  DoctorPatientAvailability.fromJson(Map<String, dynamic> json) {
    day = json['day'] as String?;
    availableFrom = json['available_from'] as String?;
    availableTo = json['available_to'] as String?;

    if (json['dates'] is List) {
      dates = (json['dates'] as List)
          .whereType<Map<String, dynamic>>()
          .map(DatesDoctorPatientAvailability.fromJson)
          .toList();
    } else {
      dates = [];
    }
  }

  String? day;
  String? availableFrom;
  String? availableTo;
  List<DatesDoctorPatientAvailability>? dates;
}

class DatesDoctorPatientAvailability {
  DatesDoctorPatientAvailability({this.date, this.bookedSlots, this.freeSlots});

  DatesDoctorPatientAvailability.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    bookedSlots = (json['booked_slots'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    freeSlots = (json['free_slots'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
  }

  String? date;
  List<String>? bookedSlots;
  List<String>? freeSlots;
}

class MergedDateAvailabilityForPatient {
  MergedDateAvailabilityForPatient({
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
  List<String> freeSlots;
}

List<MergedDateAvailabilityForPatient> mergeAndSortByDate(
  AppointmentPatientAvailableModel model,
) {
  final mergedList = <MergedDateAvailabilityForPatient>[];

  // Set لتخزين التواريخ المتكررة
  final seenDates = <String>{};
  DoctorPatientAvailability doctor;
  DatesDoctorPatientAvailability dateEntry;
  for (doctor in model.doctorAvailability ?? []) {
    final day = doctor.day ?? '';
    final from = doctor.availableFrom ?? '';
    final to = doctor.availableTo ?? '';

    for (dateEntry in doctor.dates ?? []) {
      final dateStr = dateEntry.date ?? '';
      final parsedDate = DateTime.tryParse(dateStr);

      if (parsedDate != null) {
        // إذا كان التاريخ لم يتم إضافته من قبل
        if (!seenDates.contains(dateStr)) {
          seenDates.add(dateStr);

          mergedList.add(
            MergedDateAvailabilityForPatient(
              day: day,
              dateString: dateStr,
              date: parsedDate,
              availableFrom: from,
              availableTo: to,
              freeSlots: dateEntry.freeSlots ?? [],
            ),
          );
        } else {
          // إذا كان التاريخ موجود مسبقًا، ندمج الـ freeSlots
          final existingEntry = mergedList.firstWhere(
            (e) => e.dateString == dateStr,
            orElse: () => MergedDateAvailabilityForPatient(
              day: day,
              dateString: dateStr,
              date: parsedDate,
              availableFrom: from,
              availableTo: to,
              freeSlots: [],
            ),
          );

          // دمج الـ freeSlots وحذف التكرار
          existingEntry.freeSlots.addAll(dateEntry.freeSlots ?? []);
          // إزالة التكرار باستخدام toSet()
          existingEntry.freeSlots = existingEntry.freeSlots.toSet().toList();
          existingEntry.freeSlots.sort();
        }
      }
    }
  }

  // ترتيب حسب التاريخ وتصفيه للمستقبل
  mergedList.sort((a, b) => a.date.compareTo(b.date));
  final now = DateTime.now();
  final upcomingDates = mergedList
      .where(
        (e) =>
            e.date.year > now.year ||
            (e.date.year == now.year && e.date.month > now.month) ||
            (e.date.year == now.year &&
                e.date.month == now.month &&
                e.date.day >= now.day),
      )
      .toList();

  return upcomingDates;
}
