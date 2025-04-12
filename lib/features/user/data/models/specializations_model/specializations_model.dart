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
      image: json['image'] as String,
      name: json['name'] as String,
      doctorCount: json['doctor_count'] as int,
    );
  }
  final int id;
  final String image;
  final String name;
  final int doctorCount;
}
