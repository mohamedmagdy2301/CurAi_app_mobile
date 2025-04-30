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
        (model) => model.daysOfWeek == null || model.daysOfWeek!.isEmpty);

    // تقسيم الأيام عندما تحتوي على أكثر من يوم
    final expandedModels = <WorkingTimeDoctorAvailableModel>[];
    for (final model in models) {
      if (model.daysOfWeek!.length > 1) {
        for (final day in model.daysOfWeek!) {
          // إنشاء نسخة جديدة لكل يوم مع نفس الوقت
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
        expandedModels.add(model); // إذا كانت الأيام تحتوي على يوم واحد فقط
      }
    }

    // إزالة التكرار بناءً على اليوم ووقت التوافر
    final seen = <String>{}; // مجموعة لتخزين الأيام المتكررة
    return expandedModels.where((model) {
      final dayKey = model.daysOfWeek!.join(',') +
          model.availableFrom! +
          model.availableTo!;
      if (seen.contains(dayKey)) {
        return false; // إذا كان العنصر مكررًا
      } else {
        seen.add(dayKey);
        return true; // إذا كان العنصر غير مكرر
      }
    }).toList();
  }
}
