import 'package:hive/hive.dart';

part 'specializations_model.g.dart';

@HiveType(typeId: 5)
class SpecializationsModel {
  SpecializationsModel({
    required this.id,
    required this.image,
    required this.name,
    required this.doctorCount,
  });

  factory SpecializationsModel.fromJson(Map<String, dynamic> json) {
    return SpecializationsModel(
      id: json['id'] as int,
      image: json['image'] as String? ?? '',
      name: json['name'] as String,
      doctorCount: json['doctor_count'] as int? ?? 0,
    );
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int doctorCount;
}

final List<Map<String, dynamic>> specializationsList = [
  {
    'id': 2,
    'name': 'Allergist',
  },
  {'id': 3, 'name': 'Andrologists'},
  {'id': 4, 'name': 'Anesthesiologist'},
  {'id': 1, 'name': 'Audiologist'},
  {'id': 5, 'name': 'Cardiologist'},
  {'id': 7, 'name': 'Dentist', 'doctor_count': 3},
  {'id': 8, 'name': 'Gynecologist', 'doctor_count': 0},
  {'id': 9, 'name': 'Internists', 'doctor_count': 1},
  {'id': 10, 'name': 'Orthopedist', 'doctor_count': 0},
  {'id': 11, 'name': 'Pediatrician', 'doctor_count': 0},
  {'id': 12, 'name': 'Surgeon', 'doctor_count': 1},
  {'id': 6, 'name': 'neurologist', 'doctor_count': 0},
];
