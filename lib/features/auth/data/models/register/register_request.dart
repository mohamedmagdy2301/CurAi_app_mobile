class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
    required this.fullName,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    required this.specialization,
    required this.consultationPrice,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'password_confirm': confirmPassword,
        'first_name': fullName,
        'phone_number': phoneNumber,
        'gender': gender,
        'age': age,
        'specialization': specialization,
        'consultation_price': consultationPrice,
        'location': location,
      };

  final String email;
  final String password;
  final String confirmPassword;
  final String username;
  final String fullName;
  final String phoneNumber;
  final String gender;
  final int age;
  final String specialization;
  final String consultationPrice;
  final String location;
}
