class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
    required this.role,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirm': confirmPassword,
        'username': username,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'specialization': 1,
        'consultation_price': 1,
        'location': 's',
      };

  final String email;
  final String password;
  final String confirmPassword;
  final String username;
  final String role;
  final String firstName;
  final String lastName;
}
