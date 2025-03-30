class LoginModel {
  LoginModel({
    required this.role,
    required this.username,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json['access'] as String,
        refreshToken: json['refresh'] as String,
        userId: json['user_id'] as int,
        username: json['username'] as String,
        role: json['role'] as String,
      );
  final String accessToken;
  final String refreshToken;
  final int userId;
  final String username;
  final String role;
}
