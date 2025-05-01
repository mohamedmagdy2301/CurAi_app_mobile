import 'dart:io';

class ProfileRequest {
  ProfileRequest({
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.age,
    this.specialization,
    this.consultationPrice,
    this.location,
    this.bio,
    this.latitude,
    this.longitude,
    this.role,
    this.imageFile,
  });

  final String? username;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? gender;
  final int? age;
  final String? specialization;
  final String? consultationPrice;
  final String? location;
  final String? bio;
  final String? latitude;
  final String? longitude;
  final String? role;
  final File? imageFile;
}
