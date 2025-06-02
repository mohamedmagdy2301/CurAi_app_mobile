import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:hive/hive.dart';

part 'doctor_info_model.g.dart';

@HiveType(typeId: 3)
class DoctorInfoModel extends HiveObject {
  DoctorInfoModel({
    this.id,
    this.profilePicture,
    this.username,
    this.email,
    this.specialization,
    this.consultationPrice,
    this.location,
    this.reviews,
    this.firstName,
    this.lastName,
    this.bio,
    this.latitude,
    this.longitude,
    this.avgRating,
    this.totalReviews,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      id: json['id'] as int?,
      profilePicture: json['profile_picture'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      specialization: json['specialization'] as String?,
      consultationPrice: json['consultation_price']?.toString(),
      location: json['location'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      bio: json['bio'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'] as int?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => DoctorReviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? profilePicture;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? specialization;

  @HiveField(5)
  String? consultationPrice;

  @HiveField(6)
  String? location;

  @HiveField(7)
  List<DoctorReviews>? reviews;

  @HiveField(8)
  String? firstName;

  @HiveField(9)
  String? lastName;

  @HiveField(10)
  String? bio;

  @HiveField(11)
  double? latitude;

  @HiveField(12)
  double? longitude;

  @HiveField(13)
  double? avgRating;

  @HiveField(14)
  int? totalReviews;
}

@HiveType(typeId: 4)
class DoctorReviews extends HiveObject {
  DoctorReviews({
    this.id,
    this.patientUsername,
    this.rating,
    this.comment,
    this.createdAt,
    this.profilePatientPicture,
    this.firstName,
    this.lastName,
  });

  factory DoctorReviews.fromJson(Map<String, dynamic> json) {
    return DoctorReviews(
      id: json['id'] as int?,
      patientUsername: json['patient_username'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
      profilePatientPicture: json['profile_picture'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );
  }
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? patientUsername;

  @HiveField(2)
  int? rating;

  @HiveField(3)
  String? comment;

  @HiveField(4)
  String? createdAt;

  @HiveField(5)
  String? profilePatientPicture;

  @HiveField(6)
  String? firstName;

  @HiveField(7)
  String? lastName;
}

List<DoctorInfoModel> doctorsListDome = List.generate(
  5,
  (index) => DoctorInfoModel(
    id: index,
    username: 'user name mkkm',
    profilePicture: AppImages.avatarOnlineDoctor,
    consultationPrice: index.toString(),
    email: 'nsjka bjba',
    location: 'msabnj hjdgav hdgah',
    specialization: 'sdnaj sadkldbn ',
    reviews: doctorReviewsListDome,
  ),
);

List<DoctorReviews> doctorReviewsListDome = List.generate(
  2,
  (index) => DoctorReviews(
    id: index,
    rating: index,
    comment: 'mb ,jkhbhilased gheufi hgiu hgeu gi',
    createdAt: '2022-10-10',
    profilePatientPicture: AppImages.avatarOnlinePatient,
    firstName: 'first name',
    lastName: 'last name',
    patientUsername: 'username',
  ),
);
