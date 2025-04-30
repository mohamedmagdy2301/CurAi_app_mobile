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
}
