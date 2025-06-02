class GetReviewsModel {
  GetReviewsModel({
    this.id,
    this.patientUsername,
    this.patientPicture,
    this.firstName,
    this.lastName,
    this.doctorId,
    this.doctorPicture,
    this.doctorName,
    this.rating,
    this.comment,
    this.createdAt,
  });

  GetReviewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    patientUsername = json['patient_username'] as String?;
    patientPicture = json['patient_picture'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    doctorId = json['doctor'] as int;
    doctorPicture = json['doctor_picture'] as String?;
    doctorName = json['doctor_name'] as String?;
    rating = json['rating'] as int;
    comment = json['comment'] as String?;
    createdAt = json['created_at'] as String?;
  }
  int? id;
  String? patientUsername;
  String? patientPicture;
  String? firstName;
  String? lastName;
  int? doctorId;
  String? doctorPicture;
  String? doctorName;
  int? rating;
  String? comment;
  String? createdAt;
}
