import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';

class DoctorsModel {
  DoctorsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String? ?? '',
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DoctorInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  int? count;
  String? next;
  String? previous;
  List<DoctorInfoModel>? results;
}
