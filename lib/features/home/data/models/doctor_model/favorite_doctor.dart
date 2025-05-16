import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:hive/hive.dart';

part 'favorite_doctor.g.dart';

@HiveType(typeId: 2)
class FavoriteDoctor extends HiveObject {
  FavoriteDoctor({
    required this.id,
    this.username,
    this.specialization,
    this.profilePicture,
    this.consultationPrice,
  });

  // تحويل من DoctorResults إلى FavoriteDoctor
  factory FavoriteDoctor.fromDoctorResults(DoctorResults doctor) {
    return FavoriteDoctor(
      id: doctor.id!,
      username: doctor.username,
      specialization: doctor.specialization,
      profilePicture: doctor.profilePicture,
      consultationPrice: doctor.consultationPrice,
    );
  }
  @HiveField(0)
  int id;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? specialization;

  @HiveField(3)
  String? profilePicture;

  @HiveField(4)
  String? consultationPrice;

  // تحويل من FavoriteDoctor إلى DoctorResults
  DoctorResults toDoctorResults() {
    return DoctorResults(
      id: id,
      username: username,
      specialization: specialization,
      profilePicture: profilePicture,
      consultationPrice: consultationPrice,
    );
  }
}
