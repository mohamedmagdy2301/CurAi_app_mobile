class LoginRequest {
  LoginRequest({required this.email, required this.password});
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {'username': email, 'password': password};
}
