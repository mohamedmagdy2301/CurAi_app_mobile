class AllDoctorModel {
  AllDoctorModel({this.count, this.next, this.previous, this.results});

  AllDoctorModel.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'] as String? ?? '';
    if (json['results'] != null) {
      results = <DoctorResults>[];
      json['results'].forEach((v) {
        results!.add(DoctorResults.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  int? count;
  String? next;
  String? previous;
  List<DoctorResults>? results;
}

class DoctorResults {
  DoctorResults({
    this.id,
    this.profilePicture,
    this.username,
    this.email,
    this.specialization,
    this.consultationPrice,
    this.location,
    this.reviews,
  });

  DoctorResults.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    profilePicture = json['profile_picture'] as String?;
    username = json['username'] as String?;
    email = json['email'] as String?;
    specialization = json['specialization'] as String?;
    consultationPrice = json['consultation_price'] as String?;
    location = json['location'] as String?;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v as Map<String, dynamic>));
      });
    } else {
      reviews = []; // Handle empty reviews array
    }
  }

  int? id;
  String? profilePicture;
  String? username;
  String? email;
  String? specialization;
  String? consultationPrice;
  String? location;
  List<Reviews>? reviews;
}

class Reviews {
  Reviews({
    this.id,
    this.patientUsername,
    this.rating,
    this.comment,
    this.createdAt,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    patientUsername = json['patient_username'] as String?;
    rating = json['rating'] as int?;
    comment = json['comment'] as String?;
    createdAt = json['created_at'] as String?;
  }

  int? id;
  String? patientUsername;
  int? rating;
  String? comment;
  String? createdAt;
}
