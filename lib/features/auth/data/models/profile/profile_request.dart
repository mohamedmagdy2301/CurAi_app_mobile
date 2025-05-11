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
    this.profileImage,
    this.isApproved,
    this.profileCertificate,
  });

  final String? username;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? gender;
  final String? age;
  final int? specialization;
  final String? consultationPrice;
  final String? location;
  final String? bio;
  final double? latitude;
  final double? longitude;
  final String? role;
  final File? profileImage;
  final bool? isApproved;
  final File? profileCertificate;
}
