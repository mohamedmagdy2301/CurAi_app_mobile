class WorkingTimeDoctorAvailableModel {
  WorkingTimeDoctorAvailableModel({
    this.id,
    this.doctor,
    this.availableFrom,
    this.availableTo,
    this.daysOfWeek,
  });

  WorkingTimeDoctorAvailableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    doctor = json['doctor'] as String?;
    availableFrom = json['available_from'] as String?;
    availableTo = json['available_to'] as String?;
    daysOfWeek =
        List<String>.from((json['days_of_week'] as Iterable<dynamic>?) ?? []);
  }

  int? id;
  String? doctor;
  String? availableFrom;
  String? availableTo;
  List<String>? daysOfWeek;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'available_from': availableFrom,
      'available_to': availableTo,
      'days_of_week': daysOfWeek,
    };
  }

  // Map to convert days between English and Arabic
  static const Map<String, String> _dayTranslations = {
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
    'Monday': 'الاثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
  };

  // Method to get days of the week in the current language (English/Arabic)
  List<String> getLocalizedDays({required bool isArabic}) {
    if (daysOfWeek == null) return [];

    return daysOfWeek!.map((day) {
      if (isArabic) {
        return _dayTranslations[day] ?? day;
      } else {
        return day;
      }
    }).toList();
  }

  // إزالة التكرارات والأيام الفارغة
  static List<WorkingTimeDoctorAvailableModel> removeDuplicatesAndEmptyDays(
    List<WorkingTimeDoctorAvailableModel> models,
  ) {
    // أولاً إزالة العناصر التي تحتوي على أيام فارغة
    models.removeWhere(
      (model) => model.daysOfWeek == null || model.daysOfWeek!.isEmpty,
    );

    final expandedModels = <WorkingTimeDoctorAvailableModel>[];
    for (final model in models) {
      if (model.daysOfWeek!.length > 1) {
        for (final day in model.daysOfWeek!) {
          expandedModels.add(
            WorkingTimeDoctorAvailableModel(
              id: model.id,
              doctor: model.doctor,
              availableFrom: model.availableFrom,
              availableTo: model.availableTo,
              daysOfWeek: [day],
            ),
          );
        }
      } else {
        expandedModels.add(model);
      }
    }

    final seen = <String>{};
    return expandedModels.where((model) {
      final dayKey = model.daysOfWeek!.join(',') +
          model.availableFrom! +
          model.availableTo!;
      if (seen.contains(dayKey)) {
        return false;
      } else {
        seen.add(dayKey);
        return true;
      }
    }).toList();
  }
}

final List<WorkingTimeDoctorAvailableModel> workingTimeDoctorListDummy = [
  WorkingTimeDoctorAvailableModel(
    id: 15,
    doctor: 'Mohamed123',
    availableFrom: '11:30:00',
    availableTo: '15:36:00',
    daysOfWeek: ['Wednesday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 16,
    doctor: 'Mohamed123',
    availableFrom: '10:38:10',
    availableTo: '16:36:10',
    daysOfWeek: ['Wednesday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 8,
    doctor: 'Mohamed123',
    availableFrom: '10:33:00',
    availableTo: '16:32:00',
    daysOfWeek: ['Saturday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 11,
    doctor: 'Mohamed123',
    availableFrom: '10:30:00',
    availableTo: '16:30:00',
    daysOfWeek: ['Saturday', 'Sunday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 15,
    doctor: 'Mohamed123',
    availableFrom: '10:30:00',
    availableTo: '16:06:00',
    daysOfWeek: ['Wednesday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 16,
    doctor: 'Mohamed123',
    availableFrom: '10:18:00',
    availableTo: '16:36:00',
    daysOfWeek: ['Wednesday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 17,
    doctor: 'Mohamed123',
    availableFrom: '10:48:00',
    availableTo: '16:30:00',
    daysOfWeek: ['Wednesday'],
  ),
  WorkingTimeDoctorAvailableModel(
    id: 18,
    doctor: 'Mohamed123',
    availableFrom: '10:18:00',
    availableTo: '16:36:00',
    daysOfWeek: ['Friday'],
  ),
];
