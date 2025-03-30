class ProfileModel {
  ProfileModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.age,
    this.email,
    this.role,
    this.specialization,
    this.consultationPrice,
    this.location,
    this.isApproved,
    this.profilePicture,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    username = json['username'] as String;
    firstName = (json['first_name'] ?? '') as String;
    lastName = (json['last_name'] ?? '') as String;
    phoneNumber = (json['phone_number'] ?? '') as String;
    gender = (json['gender'] ?? 'male') as String;
    age = (json['age'] ?? 0) as int;
    email = (json['email'] ?? '') as String;
    role = (json['role'] ?? '') as String;
    specialization = (json['specialization'] ?? 0) as int;
    consultationPrice = (json['consultation_price'] ?? '') as String;
    location = (json['location'] ?? '') as String;
    isApproved = (json['is_approved'] ?? false) as bool;
    profilePicture = (json['profile_picture'] ?? '') as String;
  }

  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? gender;
  int? age;
  String? email;
  String? role;
  int? specialization;
  String? consultationPrice;
  String? location;
  bool? isApproved;
  String? profilePicture;
}
