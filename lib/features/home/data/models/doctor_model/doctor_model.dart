class AllDoctorModel {
  AllDoctorModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory AllDoctorModel.fromJson(Map<String, dynamic> json) {
    return AllDoctorModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String? ?? '',
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DoctorResults.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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
    this.firstName,
    this.lastName,
    this.bio,
    this.latitude,
    this.longitude,
    this.avgRating,
    this.totalReviews,
  });

  factory DoctorResults.fromJson(Map<String, dynamic> json) {
    return DoctorResults(
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
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  int? id;
  String? profilePicture;
  String? username;
  String? email;
  String? specialization;
  String? consultationPrice;
  String? location;
  List<Reviews>? reviews;
  String? firstName;
  String? lastName;
  String? bio;
  double? latitude;
  double? longitude;
  double? avgRating;
  int? totalReviews;
}

class Reviews {
  Reviews({
    this.id,
    this.patientUsername,
    this.rating,
    this.comment,
    this.createdAt,
    this.profilePatientPicture,
    this.firstName,
    this.lastName,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
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

  int? id;
  String? patientUsername;
  int? rating;
  String? comment;
  String? createdAt;
  String? profilePatientPicture;
  String? firstName;
  String? lastName;
}

List<DoctorResults> doctorsListDome = List.generate(
  5,
  (index) => DoctorResults(
    id: index,
    username: 'user name mkkm',
    profilePicture:
        'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    consultationPrice: index.toString(),
    email: 'nsjka bjba',
    location: 'msabnj hjdgav hdgah',
    specialization: 'sdnaj sadkldbn ',
    reviews: List.generate(
      5,
      (index) => Reviews(
        id: index,
        rating: index,
      ),
    ),
  ),
);
