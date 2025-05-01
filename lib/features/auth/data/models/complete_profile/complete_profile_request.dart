import 'dart:io';

class CompleteProfileRequest {
  CompleteProfileRequest({
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

  Map<String, dynamic> toJson() => {
        'first_name': firstName ?? ' ',
        'last_name': lastName ?? ' ',
        'phone_number': phoneNumber ?? ' ',
        'gender': gender ?? 'male',
        'age': age ?? 0,
        'specialization': specialization ?? 1,
        'consultation_price': consultationPrice ?? 0,
        'location': location ?? 'm',
        'bio': bio ?? ' ',
        'latitude': latitude ?? 0.0,
        'longitude': longitude ?? 0.0,
        'role': role ?? 'patient',
        'profile_picture': imageFile,
      };

  final int? age;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? gender;
  final String? specialization;
  final String? consultationPrice;
  final String? location;
  final String? bio;
  final String? latitude;
  final String? longitude;
  final String? role;
  final File? imageFile;
}
