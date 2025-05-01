class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
    this.fullName,
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
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirm': confirmPassword,
        'username': username,
        'first_name': fullName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'gender': gender,
        'age': age,
        'specialization': specialization,
        'consultation_price': consultationPrice,
        'location': location,
        'bio': bio,
        'latitude': latitude,
        'longitude': longitude,
        'role': role,
      };

  final String email;
  final String password;
  final String confirmPassword;
  final String username;
  final String? fullName;
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
}
