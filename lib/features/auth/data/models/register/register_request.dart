class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirm': confirmPassword,
        'username': username,
      };

  final String email;
  final String password;
  final String confirmPassword;
  final String username;
}
