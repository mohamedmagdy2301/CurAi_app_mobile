class ProfileRequest {
  ProfileRequest({
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
        'username': username,
        'first_name': fullName,
        'phone_number': phoneNumber,
        'gender': gender,
        'age': age,
        'specialization': specialization,
        'consultation_price': consultationPrice,
        'location': location,
      };

  final String username;
  final String fullName;
  final String phoneNumber;
  final String gender;
  final int age;
  final String specialization;
  final String consultationPrice;
  final String location;
}
